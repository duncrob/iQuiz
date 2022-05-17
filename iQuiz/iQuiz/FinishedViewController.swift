//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by stlp on 5/16/22.
//

import UIKit

class FinishedViewController: UIViewController {

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var resultText: UILabel!
    
    var finalScore: Int = 0
    var numQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ratio: Double = Double(finalScore) / Double(numQuestions)
        
        var finalText: String
        
        if ratio == 1.0 {
            finalText = "Perfect score!"
        }
        else if ratio >= 0.5 {
            finalText = "Not too bad!"
        }
        else {
            finalText = "Try again next time."
        }
        
        resultText.text = finalText
        scoreText.text = "\(finalScore) of \(numQuestions) correct"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ToHome", sender: self)
    }

}
