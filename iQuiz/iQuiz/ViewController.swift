//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/10/22.
//

import UIKit

class SubjectCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subjectImage: UIImageView!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var subjects : [String] = [
        "Mathematics", "Marvel Super Heroes", "cat"
    ]
    
    var descriptions : [String] = [
        "A math quiz", "A superhero quiz", "A science quiz"
    ]
    
    var currentUrl: String = UserDefaults.standard.string(forKey: "currentUrl")!
    var quizData: [Dictionary<String, Any>] = []
    var currentQuizIndex: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subject", for: indexPath) as! SubjectCell
        
        cell.title?.text = subjects[indexPath.row]
        cell.descriptionLabel?.text = descriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentQuizIndex = indexPath.row
        performSegue(withIdentifier: "ToQuestion", sender: self)
    }

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var subjectTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("data.json")

            let readData = try Data(contentsOf: fileURL)
            let dictionary = try JSONSerialization.jsonObject(with: readData) as! [Dictionary<String, Any>]
            self.updateQuizzes(data: dictionary)
        } catch {
            print(error)
        }
        
        fetchData(url: URL(string: currentUrl)!, completion: {
            data in
            if let data = data {
                self.updateQuizzes(data: data)
                
                // write to file
                do {
                    let fileURL = try FileManager.default
                        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        .appendingPathComponent("data.json")
                    try JSONSerialization.data(withJSONObject: data)
                        .write(to: fileURL)
                } catch {
                    print(error)
                }
            }
        })

        subjectTable.rowHeight = 100
        
        subjectTable.dataSource = self
        subjectTable.delegate = self
    }
    
    func updateQuizzes(data: [Dictionary<String, Any>]) {
        var newSubjects: [String] = []
        var newDescriptions: [String] = []
        
        for quiz in data {
            self.quizData.append(quiz)
            newSubjects.append(quiz["title"] as! String)
            newDescriptions.append(quiz["desc"] as! String)
        }
        
        self.subjects = newSubjects
        self.descriptions = newDescriptions
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func pressSettings(_ sender: Any) {
        performSegue(withIdentifier: "ToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionViewController {
            let vc = segue.destination as? QuestionViewController
            let currentQuiz = quizData[currentQuizIndex]
            var questions: [String] = []
            var answers: [[String]] = []
            var correctAnswers: [String] = []
            
            for question in currentQuiz["questions"] as! [Dictionary<String, Any>] {
                questions.append(question["text"] as! String)
                answers.append(question["answers"] as! [String])
                correctAnswers.append((question["answer"] as! String))
            }
            
            vc?.questions = questions
            vc?.answers = answers
            vc?.correctAnswers = correctAnswers
            vc?.currentQuestion = 0
            vc?.currentScore = 0
        }
        if segue.destination is SettingsViewController {
            let vc = segue.destination as? SettingsViewController
            vc?.currentUrl = currentUrl
        }
    }
    
    func fetchData(url: URL, completion: @escaping ((([Dictionary<String, Any>])?) -> Void)) {
        var questions: [Dictionary<String, Any>] = []
        let session = URLSession.shared.dataTask(with: URL(string: currentUrl)!) {
            data, response, error in

            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    self.presentNetworkError()
                }
                do {
                    questions = try JSONSerialization.jsonObject(with: data!) as! [Dictionary<String, Any>]
                    completion(questions)
                }
                catch {
                    print("Something went boom")
                }
            }
            else {
                self.presentNetworkError()
            }
        }
        session.resume()
    }
    
    func presentNetworkError() {
        let dialogMessage = UIAlertController(title: "Attention", message: "There was an error contacting the network", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
}

