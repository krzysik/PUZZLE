//
//  LevelViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    @IBOutlet weak var Level2: UIButton!
    @IBOutlet weak var Level3: UIButton!
    @IBOutlet weak var Level4: UIButton!
    @IBOutlet weak var Level5: UIButton!
    @IBOutlet weak var Level6: UIButton!
    @IBOutlet weak var Level1: UIButton!
    @IBOutlet weak var Level7: UIButton!
    @IBOutlet weak var Level8: UIButton!
    @IBOutlet weak var Level9: UIButton!
    @IBOutlet weak var Level10: UIButton!
    var darkTheme = false
    @IBOutlet weak var LabelSelect: UILabel!
    @IBOutlet weak var LabelEasy: UILabel!
    @IBOutlet weak var LabelMedium: UILabel!
    @IBOutlet weak var LabelHard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var darkTheme = UserDefaults.standard.bool(forKey: "Dark")
        if(darkTheme == true){
            self.view.backgroundColor = UIColor.black
            LabelEasy.textColor=UIColor.white
            LabelHard.textColor=UIColor.white
            LabelMedium.textColor=UIColor.white
            LabelSelect.textColor=UIColor.white
        }else{
            self.view.backgroundColor = UIColor.white
            LabelEasy.textColor=UIColor.black
                       LabelHard.textColor=UIColor.black
                       LabelMedium.textColor=UIColor.black
                       LabelSelect.textColor=UIColor.black
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Level6OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set(6, forKey: "Level")
    }
    @IBAction func Level7OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set(7, forKey: "Level")
    }
    
    @IBAction func Level8OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
               
               self.navigationController?.pushViewController(vc,animated: true)
               UserDefaults.standard.set(8, forKey: "Level")
    }
    @IBAction func Level9OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
               
               self.navigationController?.pushViewController(vc,animated: true)
               UserDefaults.standard.set(9, forKey: "Level")
    }
    @IBAction func Level10OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
               
               self.navigationController?.pushViewController(vc,animated: true)
               UserDefaults.standard.set(10, forKey: "Level")
    }
    @IBAction func Level1OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EasyViewController") as! EasyViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set(1, forKey: "Level")
    }
    @IBAction func Level2OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EasyViewController") as! EasyViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set(2, forKey: "Level")
    }
    @IBAction func Level3OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EasyViewController") as! EasyViewController
        
        self.navigationController?.pushViewController(vc,animated: true)
        UserDefaults.standard.set(3, forKey: "Level")
    }
    @IBAction func Level4OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EasyViewController") as! EasyViewController
               
               self.navigationController?.pushViewController(vc,animated: true)
               UserDefaults.standard.set(4, forKey: "Level")
    }
    @IBAction func Level5OnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EasyViewController") as! EasyViewController
               
               self.navigationController?.pushViewController(vc,animated: true)
               UserDefaults.standard.set(5, forKey: "Level")
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
