//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by stlp on 5/16/22.
//

import UIKit

class AnswerCell: UITableViewCell {
    @IBOutlet weak var answerText: UILabel!
}

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectedAnswerText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    var questions: [String] = []
    var answers : [[String]] = []
    var correctAnswers: [String] = []
    var currentQuestion: Int = 0
    var currentScore: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers[currentQuestion].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answer", for: indexPath) as! AnswerCell
        
        cell.answerText?.text = answers[currentQuestion][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswerText.isHidden = false
        nextButton.isEnabled = true
        
        selectedAnswerText.text = answers[currentQuestion][indexPath.row]
    }
    

    @IBOutlet weak var answerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerTable.dataSource = self
        answerTable.delegate = self
        selectedAnswerText.isHidden = true
        nextButton.isEnabled = false
        questionText.text = questions[currentQuestion]
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ToAnswer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnswerViewController {
            let vc = segue.destination as? AnswerViewController
            let correctAnswerIndex = Int(correctAnswers[currentQuestion])! - 1
            vc?.correctAnswer = answers[currentQuestion][correctAnswerIndex]
            vc?.yourAnswer = selectedAnswerText.text!
            vc?.currentScore = currentScore
            vc?.correctAnswers = correctAnswers
            vc?.questions = questions
            vc?.answers = answers
            vc?.currentQuestion = currentQuestion
        }
    }
}
