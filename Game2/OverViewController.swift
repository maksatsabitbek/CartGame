//
//  OverViewController.swift
//  Game2
//
//  Created by Мас on 24.02.2021.
//

import UIKit

class OverViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Collect the value stored in userdefaults and put it in the label
        score.text = UserDefaults.standard.string(forKey: "points")! + " pts."
        
        // Check if the key exists in user defaults of bestScore, in case it exists it puts it in the label.
        if let bestOne = UserDefaults.standard.string(forKey: "bestScore") {
            bestScore.text = "Best Score: " + bestOne + " pts."
        }
    }
    
}
