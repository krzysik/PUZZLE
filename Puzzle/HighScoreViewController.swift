//
//  HighScoreViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController 	{
    
    
    var darkTheme = false
    
    @IBAction func EasyOnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelHighscoreViewController") as! LevelHighscoreViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set("Easy", forKey: "Level")
    }
    @IBAction func MediumOnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelHighscoreViewController") as! LevelHighscoreViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set("Medium", forKey: "Level")
    }
    @IBAction func HardOnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelHighscoreViewController") as! LevelHighscoreViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set("Hard", forKey: "Level")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkTheme = UserDefaults.standard.bool(forKey: "Dark")
        if(darkTheme == true){
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        
        
    }

    

    
}
