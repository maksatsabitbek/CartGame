//
//  ViewController.swift
//  Game2
//
//  Created by Rustem Orazbek on 24.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstGame: UIButton!
    @IBOutlet weak var secondGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func play1stGame(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func play2ndGame(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondGameViewController") as! SecondGameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

