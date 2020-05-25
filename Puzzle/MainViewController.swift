//
//  ViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import UIKit
import AVFoundation
class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var level = 0
    var darkTheme = false
    var audioPlayer:AVAudioPlayer?
    var toSolveImageArray = [UIImage]()
    var correctAns = [Int]()
    var wrongAns = Array(0..<9)
    var wrongImageArray=[UIImage]()
    var undoMovesArray = [(first: IndexPath, second: IndexPath)]()
    var numberOfMoves = 0
    
    var firstIndexPath: IndexPath?
    var secondIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level = UserDefaults.standard.integer(forKey: "Level")
        if(level == 6){
              toSolveImageArray = [#imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2")]
             correctAns = [0,1,4,5,6,2,3,8,7]
             wrongImageArray = toSolveImageArray
            
        }else if(level == 7){
            toSolveImageArray = [#imageLiteral(resourceName: "52"),#imageLiteral(resourceName: "62"),#imageLiteral(resourceName: "42"),#imageLiteral(resourceName: "32"),#imageLiteral(resourceName: "22"),#imageLiteral(resourceName: "92"),#imageLiteral(resourceName: "72"),#imageLiteral(resourceName: "82"),#imageLiteral(resourceName: "12")]
           correctAns = [5,7,6,1,0,2,3,4,8]
             wrongImageArray = toSolveImageArray
        }else if(level == 8){
            toSolveImageArray = [#imageLiteral(resourceName: "43"),#imageLiteral(resourceName: "33"),#imageLiteral(resourceName: "63"),#imageLiteral(resourceName: "93"),#imageLiteral(resourceName: "53"),#imageLiteral(resourceName: "13"),#imageLiteral(resourceName: "73"),#imageLiteral(resourceName: "83"),#imageLiteral(resourceName: "23")]
            correctAns = [3,7,6,2,4,0,1,8,5]
              wrongImageArray = toSolveImageArray
        }else if(level == 9){
            toSolveImageArray = [#imageLiteral(resourceName: "34"),#imageLiteral(resourceName: "74"),#imageLiteral(resourceName: "44"),#imageLiteral(resourceName: "84"),#imageLiteral(resourceName: "94"),#imageLiteral(resourceName: "54"),#imageLiteral(resourceName: "24"),#imageLiteral(resourceName: "14"),#imageLiteral(resourceName: "64")]
            correctAns = [4,3,1,8,5,2,0,6,7]
              wrongImageArray = toSolveImageArray
        }else if(level == 10){
            toSolveImageArray = [#imageLiteral(resourceName: "85"),#imageLiteral(resourceName: "25"),#imageLiteral(resourceName: "75"),#imageLiteral(resourceName: "35"),#imageLiteral(resourceName: "65"),#imageLiteral(resourceName: "45"),#imageLiteral(resourceName: "55"),#imageLiteral(resourceName: "15"),#imageLiteral(resourceName: "95")]
            correctAns = [8,0,2,4,6,5,3,1,7]
              wrongImageArray = toSolveImageArray
        }
        self.title = "Puzzle"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "<Back",style: UIBarButtonItem.Style.plain,target: self,action:#selector(MainViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
       var darkTheme = UserDefaults.standard.bool(forKey: "Dark")
       if(darkTheme == true){
           self.view.backgroundColor = UIColor.black
        lblMoves.textColor=UIColor.white
       }else{
           self.view.backgroundColor = UIColor.white
        lblMoves.textColor=UIColor.black
       }
        setupViews()
    }
    @objc func back(sender:UIBarButtonItem){
        level=0
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSwapAction() {
        guard let start = firstIndexPath, let end = secondIndexPath else { return }
        myCollectionView.performBatchUpdates({
            myCollectionView.moveItem(at: start, to: end)
            myCollectionView.moveItem(at: end, to: start)
        }) { (finished) in
            // update data source here
//            print(wrongAns)
            self.myCollectionView.deselectItem(at: start, animated: true)
            self.myCollectionView.deselectItem(at: end, animated: true)
            self.firstIndexPath = nil
            self.secondIndexPath = nil
            self.wrongImageArray.swapAt(start.item, end.item)
            self.wrongAns.swapAt(start.item, end.item)
            self.undoMovesArray.append((first: start, second: end))
            self.numberOfMoves += 1
            self.lblMoves.text = "Moves: \(self.numberOfMoves)"
            if self.wrongAns == self.correctAns {
                let pathToSound=Bundle.main.path(forResource: "success", ofType: "wav")!
                let url=URL(fileURLWithPath: pathToSound)
                do{
                    self.audioPlayer=try AVAudioPlayer(contentsOf: url)
                    self.audioPlayer?.play()
                }catch{
                    
                }
                let alert=UIAlertController(title: "You Won!", message: "Congratulations 👍", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (action) in
                    self.restartGame()
                })
                alert.addAction(okAction)
                alert.addAction(restartAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func restartGame() {
        self.undoMovesArray.removeAll()
        wrongAns = Array(0..<9)
        wrongImageArray = toSolveImageArray
        firstIndexPath = nil
        secondIndexPath = nil
        self.numberOfMoves = 0
        self.lblMoves.text = "Moves: \(numberOfMoves)"
        self.myCollectionView.reloadData()
    }
    
    @objc func btnUndoAction() {
        if undoMovesArray.count == 0 {
            return
        }
        let start = undoMovesArray.last!.first
        let end = undoMovesArray.last!.second
        myCollectionView.performBatchUpdates({
            myCollectionView.moveItem(at: start, to: end)
            myCollectionView.moveItem(at: end, to: start)
        }) { (finished) in
            // update data source here
            self.wrongImageArray.swapAt(start.item, end.item)
            self.wrongAns.swapAt(start.item, end.item)
            self.undoMovesArray.removeLast()
            self.numberOfMoves += 1
            self.lblMoves.text = "Moves: \(self.numberOfMoves)"
        }
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageViewCVCell
        cell.imgView.image=wrongImageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if firstIndexPath == nil {
            firstIndexPath = indexPath
            collectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        } else if secondIndexPath == nil {
            secondIndexPath = indexPath
            collectionView.selectItem(at: secondIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        } else {
            collectionView.deselectItem(at: secondIndexPath!, animated: true)
            secondIndexPath = indexPath
            collectionView.selectItem(at: secondIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath == firstIndexPath {
            firstIndexPath = nil
        } else if indexPath == secondIndexPath {
            secondIndexPath = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3, height: width/3)
    }
    
    func setupViews() {
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImageViewCVCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor.white
        
        self.view.addSubview(myCollectionView)
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -21).isActive=true
        myCollectionView.heightAnchor.constraint(equalTo: myCollectionView.widthAnchor).isActive=true
        
        self.view.addSubview(btnSwap)
        btnSwap.widthAnchor.constraint(equalToConstant: 200).isActive=true
        btnSwap.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor, constant: 20).isActive=true
        btnSwap.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnSwap.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnSwap.addTarget(self, action: #selector(btnSwapAction), for: .touchUpInside)
        
        self.view.addSubview(btnUndo)
        btnUndo.widthAnchor.constraint(equalToConstant: 200).isActive=true
        btnUndo.topAnchor.constraint(equalTo: btnSwap.bottomAnchor, constant: 30).isActive=true
        btnUndo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnUndo.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnUndo.addTarget(self, action: #selector(btnUndoAction), for: .touchUpInside)
        
        self.view.addSubview(lblMoves)
        lblMoves.widthAnchor.constraint(equalToConstant: 200).isActive=true
        lblMoves.topAnchor.constraint(equalTo: btnUndo.bottomAnchor, constant: 20).isActive=true
        lblMoves.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblMoves.heightAnchor.constraint(equalToConstant: 50).isActive=true
        lblMoves.text = "Moves: \(numberOfMoves)"
    }
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = true
        cv.translatesAutoresizingMaskIntoConstraints=false
        return cv
    }()
    
    let btnSwap: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("Swap", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let btnUndo: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("Undo", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let lblMoves: UILabel = {
        let lbl=UILabel()
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}
