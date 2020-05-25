//
//  HighScoreViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {
var darkTheme = false
    override func viewDidLoad() {
        super.viewDidLoad()
        darkTheme = UserDefaults.standard.bool(forKey: "Dark")
        if(darkTheme == true){
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
