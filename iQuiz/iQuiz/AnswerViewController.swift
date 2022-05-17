//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by stlp on 5/16/22.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var indicatorText: UILabel!
    @IBOutlet weak var correctAnswerText: UILabel!
    @IBOutlet weak var yourAnswerText: UILabel!
    
    var correctAnswer: String = ""
    var yourAnswer: String = ""
    var questions: [String] = []
    var answers : [[String]] = []
    var currentQuestion: Int = 0
    var currentScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correctAnswer == yourAnswer {
            indicatorText.text = "CORRECT"
            indicatorText.textColor = UIColor.green
            currentScore += 1
        }
        else {
            indicatorText.text = "WRONG"
            indicatorText.textColor = UIColor.red
        }
        
        correctAnswerText.text = correctAnswer
        yourAnswerText.text = yourAnswer
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentQuestion += 1
        if currentQuestion < answers.count {
            performSegue(withIdentifier: "ToQuestion", sender: self)
        }
        else {
            performSegue(withIdentifier: "ToFinish", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionViewController {
            let vc = segue.destination as? QuestionViewController
            vc?.questions = questions
            vc?.answers = answers
            vc?.currentQuestion = currentQuestion
            vc?.currentScore = currentScore
        }
        
        if segue.destination is FinishedViewController {
            let vc = segue.destination as? FinishedViewController
            vc?.finalScore = currentScore
            vc?.numQuestions = questions.count
        }
    }
}
