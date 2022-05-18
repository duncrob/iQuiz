//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by stlp on 5/17/22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var urlInput: UITextField!
    
    var currentUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlInput.text = currentUrl
        
    }
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        UserDefaults.standard.setValue(currentUrl, forKey: "currentUrl")
        performSegue(withIdentifier: "ToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let vc = segue.destination as? ViewController
            vc?.currentUrl = urlInput.text!
        }
    }
}
