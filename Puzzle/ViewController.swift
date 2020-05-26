//
//  MainViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController {
    @IBOutlet weak var Highscore: UIButton!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var LabelTheme: UILabel!
    @IBOutlet weak var LabelWelcome: UILabel!
    
    @IBOutlet weak var Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       UserDefaults.standard.set(false, forKey: "Dark")
            
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func xyz(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
                   
                   self.navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func HighScoreOnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController") as! HighScoreViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func ThemeOnSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.view.backgroundColor = UIColor.black
            LabelTheme.textColor=UIColor.white
            LabelWelcome.textColor=UIColor.white
            UserDefaults.standard.set(true, forKey: "Dark")
        }else{
            self.view.backgroundColor = UIColor.white
            LabelTheme.textColor=UIColor.black
            LabelWelcome.textColor=UIColor.black
            UserDefaults.standard.set(false, forKey: "Dark")
            
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
