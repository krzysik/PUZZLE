//
//  ViewController.swift
//  Puzzle
//
//  Created by Pollock on 24/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//
import AVFoundation
import UIKit
import FirebaseDatabase
class EasyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var level = 0
    var ref:DatabaseReference?
    var darkTheme = false
    var audioPlayer:AVAudioPlayer?
    var toSolveImageArray = [UIImage]()
    var correctAns = [Int]()
    var wrongAns = Array(0..<4)
    var wrongImageArray=[UIImage]()
    var undoMovesArray = [(first: IndexPath, second: IndexPath)]()
    var numberOfMoves = 0
    
    var firstIndexPath: IndexPath?
    var secondIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        level = UserDefaults.standard.integer(forKey: "Level")
        if(level == 1){
            toSolveImageArray = [#imageLiteral(resourceName: "l1"),#imageLiteral(resourceName: "l2"),#imageLiteral(resourceName: "l4"),#imageLiteral(resourceName: "l3")]
             correctAns = [0,1,3,2]
             wrongImageArray = toSolveImageArray
            
        }else if(level == 2){
            toSolveImageArray = [#imageLiteral(resourceName: "l32"),#imageLiteral(resourceName: "l42"),#imageLiteral(resourceName: "l22"),#imageLiteral(resourceName: "l12")]
           correctAns = [1,0,2,3]
             wrongImageArray = toSolveImageArray
        }else if(level == 3){
            toSolveImageArray = [#imageLiteral(resourceName: "l13"),#imageLiteral(resourceName: "l33"),#imageLiteral(resourceName: "l43"),#imageLiteral(resourceName: "l23")]
            correctAns = [0,3,1,2]
              wrongImageArray = toSolveImageArray
        }else if(level == 4){
            toSolveImageArray = [#imageLiteral(resourceName: "l24"),#imageLiteral(resourceName: "l44"),#imageLiteral(resourceName: "l34"),#imageLiteral(resourceName: "l14")]
            correctAns = [1,2,0,3]
              wrongImageArray = toSolveImageArray
        }else if(level == 5){
            toSolveImageArray = [#imageLiteral(resourceName: "l45"),#imageLiteral(resourceName: "l25"),#imageLiteral(resourceName: "l35"),#imageLiteral(resourceName: "l15")]
            correctAns = [0,2,1,3]
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
                if(self.level==1){
                    self.ref?.child("Easy").child("Level1").child("Score").setValue(self.numberOfMoves)
                }else if(self.level==2){
                    self.ref?.child("Easy").child("Level2").child("Score").setValue(self.numberOfMoves)
                }else if(self.level==3){
                    self.ref?.child("Easy").child("Level3").child("Score").setValue(self.numberOfMoves)
                }else if(self.level==4){
                    self.ref?.child("Easy").child("Level4").child("Score").setValue(self.numberOfMoves)
                }else if(self.level==5){
                    self.ref?.child("Easy").child("Level5").child("Score").setValue(self.numberOfMoves)
                }
                let alert=UIAlertController(title: "You Won!", message: "Congratulations :)", preferredStyle: .alert)
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
        wrongAns = Array(0..<4)
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
        return 4
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
        return CGSize(width: width/2, height: width/3)
    }
    
    func setupViews() {
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImageViewCVCell.self, forCellWithReuseIdentifier: "Cell")
        var darkTheme = UserDefaults.standard.bool(forKey: "Dark")
        if(darkTheme == true){
            myCollectionView.backgroundColor = UIColor.black
        }else{
            myCollectionView.backgroundColor = UIColor.white
        }
        
        
        self.view.addSubview(myCollectionView)
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -21).isActive=true
        myCollectionView.heightAnchor.constraint(equalTo: myCollectionView.widthAnchor).isActive=true
        
        self.view.addSubview(btnSwap)
        btnSwap.widthAnchor.constraint(equalToConstant: 374).isActive=true
        btnSwap.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor, constant: 20).isActive=true
        btnSwap.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnSwap.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnSwap.addTarget(self, action: #selector(btnSwapAction), for: .touchUpInside)
        
        self.view.addSubview(btnUndo)
        btnUndo.widthAnchor.constraint(equalToConstant: 374).isActive=true
        btnUndo.topAnchor.constraint(equalTo: btnSwap.bottomAnchor, constant: 30).isActive=true
        btnUndo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnUndo.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnUndo.addTarget(self, action: #selector(btnUndoAction), for: .touchUpInside)
        
        self.view.addSubview(lblMoves)
        lblMoves.widthAnchor.constraint(equalToConstant: 374).isActive=true
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
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let btnUndo: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("Undo", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let lblMoves: UILabel = {
        let lbl=UILabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}
