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

class SubjectDataAndDelegate : NSObject, UITableViewDataSource, UITableViewDelegate {
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
}

class ViewController: UIViewController {
    
    var subjectDataAndDelegate = SubjectDataAndDelegate()

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var subjectTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        subjectTable.rowHeight = 100
        
        subjectTable.dataSource = subjectDataAndDelegate
        subjectTable.delegate = subjectDataAndDelegate
    }

    @IBAction func pressSettings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

