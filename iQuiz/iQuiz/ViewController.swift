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
    let subjects : [String] = [
        "Mathematics", "Marvel Super Heroes", "Science"
    ]
    
    let descriptions : [String] = [
        "A math quiz", "A superhero quiz", "A science quiz"
    ]
    
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
        performSegue(withIdentifier: "ToQuestion", sender: self)
    }

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var subjectTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        subjectTable.rowHeight = 100
        
        subjectTable.dataSource = self
        subjectTable.delegate = self
    }
    

    @IBAction func pressSettings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionViewController {
            let vc = segue.destination as? QuestionViewController
            vc?.questions = ["This is example question 1?", "This is an example question 2?"]
            vc?.answers = [["Incorrect Answer", "Correct Answer", "Incorrect Answer", "Incorrect Answer"], ["Incorrect Answer", "Correct Answer", "Incorrect Answer", "Incorrect Answer"]]
            vc?.currentQuestion = 0
            vc?.currentScore = 0
        }
    }
    
}

//class quizSet {
//    var Questions: [String] = []
//    var Answers: [[String]] = []
//
//    init (Questions: [String], Answers: [[String]]) {
//        self.Questions = Questions
//        self.Answers = Answers
//    }
//}

