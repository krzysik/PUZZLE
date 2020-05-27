//
//  LevelHighscoreViewController.swift
//  Puzzle
//
//  Created by Patryk Cygan on 27/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//
import FirebaseDatabase
import UIKit

class LevelHighscoreViewController: UIViewController {
    var ref:DatabaseReference?
    var darkTheme = false
    @IBOutlet weak var Level1Label: UILabel!
    @IBOutlet weak var Level2Label: UILabel!
    @IBOutlet weak var Level3Label: UILabel!
    @IBOutlet weak var Level4Label: UILabel!
    @IBOutlet weak var Level5Label: UILabel!
    @IBOutlet weak var Level1Score: UILabel!
    @IBOutlet weak var Level2Score: UILabel!
    @IBOutlet weak var Level3Score: UILabel!
    @IBOutlet weak var Level4Score: UILabel!
    @IBOutlet weak var Level5Score: UILabel!
    @IBOutlet weak var DifficultyLabel: UILabel!
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        
        darkTheme = UserDefaults.standard.bool(forKey: "Dark")
        if(darkTheme == true){
            self.view.backgroundColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
        }
        
        let level = UserDefaults.standard.string(forKey: "Level")
        if(level == "Easy"){
            
            self.DifficultyLabel.text = "Easy"
         self.ref?.child("Easy").child("Level1").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = value?["Score"] as! Int
            self.Level1Score.text = String(score)
            self.Level1Label.text = "Level1"
        }){(error)in
            print(error.localizedDescription)
        }

         self.ref?.child("Easy").child("Level2").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = value?["Score"] as! Int
            self.Level2Score.text = String(score)
            self.Level2Label.text = "Level2"
        }){(error)in
            print(error.localizedDescription)
        }
         self.ref?.child("Easy").child("Level3").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = value?["Score"] as! Int
            self.Level3Score.text = String(score)
            self.Level3Label.text = "Level3"
        }){(error)in
            print(error.localizedDescription)
        }
         self.ref?.child("Easy").child("Level4").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = value?["Score"] as! Int
            self.Level4Score.text = String(score)
            self.Level4Label.text = "Level4"
        }){(error)in
            print(error.localizedDescription)
        }
         self.ref?.child("Easy").child("Level5").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let score = value?["Score"] as! Int
            self.Level5Score.text = String(score)
            self.Level5Label.text = "Level5"
        }){(error)in
            print(error.localizedDescription)
        }
    }
       else if(level == "Medium"){
            self.DifficultyLabel.text = "Medium"
             self.ref?.child("Medium").child("Level6").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level1Score.text = String(score)
                self.Level1Label.text = "Level6"
            }){(error)in
                print(error.localizedDescription)
            }

             self.ref?.child("Medium").child("Level7").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level2Score.text = String(score)
                self.Level2Label.text = "Level7"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Medium").child("Level8").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level3Score.text = String(score)
                self.Level3Label.text = "Level8"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Medium").child("Level9").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level4Score.text = String(score)
                self.Level4Label.text = "Level9"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Medium").child("Level10").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level5Score.text = String(score)
                self.Level5Label.text = "Level10"
            }){(error)in
                print(error.localizedDescription)
            }
        }
        else if(level == "Hard"){
            self.DifficultyLabel.text = "Hard"
             self.ref?.child("Hard").child("Level11").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level1Score.text = String(score)
                self.Level1Label.text = "Level11"
            }){(error)in
                print(error.localizedDescription)
            }

             self.ref?.child("Hard").child("Level12").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level2Score.text = String(score)
                self.Level2Label.text = "Level12"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Hard").child("Level13").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level3Score.text = String(score)
                self.Level3Label.text = "Level13"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Hard").child("Level14").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level4Score.text = String(score)
                self.Level4Label.text = "Level14"
            }){(error)in
                print(error.localizedDescription)
            }
             self.ref?.child("Hard").child("Level15").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let score = value?["Score"] as! Int
                self.Level5Score.text = String(score)
                self.Level5Label.text = "Level15"
            }){(error)in
                print(error.localizedDescription)
            }
        }
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
