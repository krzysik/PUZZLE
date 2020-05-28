
    import UIKit
    import AVFoundation
import FirebaseDatabase
    class HardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        var level = 0
        var darkTheme = false
   var audioPlayer:AVAudioPlayer?
        var toSolveImageArray = [UIImage]()
        var correctAns = [Int]()
        var wrongAns = Array(0..<16)
        var wrongImageArray=[UIImage]()
        var undoMovesArray = [(first: IndexPath, second: IndexPath)]()
        var numberOfMoves = 0
        var ref:DatabaseReference?
        var firstIndexPath: IndexPath?
        var secondIndexPath: IndexPath?
        
        override func viewDidLoad() {
            super.viewDidLoad()
               ref = Database.database().reference()
            level = UserDefaults.standard.integer(forKey: "Level")
            if(level == 11){	
                toSolveImageArray = [#imageLiteral(resourceName: "row-4-col-4"), #imageLiteral(resourceName: "row-4-col-3"), #imageLiteral(resourceName: "row-4-col-2"), #imageLiteral(resourceName: "row-4-col-1"), #imageLiteral(resourceName: "row-3-col-4"), #imageLiteral(resourceName: "row-3-col-3"), #imageLiteral(resourceName: "row-3-col-2"), #imageLiteral(resourceName: "row-3-col-1"), #imageLiteral(resourceName: "row-2-col-4"), #imageLiteral(resourceName: "row-2-col-3"),#imageLiteral(resourceName: "row-2-col-2"),#imageLiteral(resourceName: "row-2-col-1"),#imageLiteral(resourceName: "row-1-col-4"),#imageLiteral(resourceName: "row-1-col-3"),#imageLiteral(resourceName: "row-1-col-2"),#imageLiteral(resourceName: "row-1-col-1")]
                 correctAns = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
                 wrongImageArray = toSolveImageArray
                
            }else if(level == 12){
                toSolveImageArray = [#imageLiteral(resourceName: "lon16"), #imageLiteral(resourceName: "lon15"), #imageLiteral(resourceName: "lon14"), #imageLiteral(resourceName: "lon13"), #imageLiteral(resourceName: "lon12"), #imageLiteral(resourceName: "lon11"), #imageLiteral(resourceName: "lon10"), #imageLiteral(resourceName: "lon9"), #imageLiteral(resourceName: "lon8"), #imageLiteral(resourceName: "lon7"),#imageLiteral(resourceName: "lon6"),#imageLiteral(resourceName: "lon5"),#imageLiteral(resourceName: "lon4"),#imageLiteral(resourceName: "lon3"),#imageLiteral(resourceName: "lon2"),#imageLiteral(resourceName: "lon1")]
                 correctAns = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
                 wrongImageArray = toSolveImageArray
            }else if(level == 13){
                toSolveImageArray = [#imageLiteral(resourceName: "nyc16"), #imageLiteral(resourceName: "nyc15"), #imageLiteral(resourceName: "nyc14"), #imageLiteral(resourceName: "nyc13"), #imageLiteral(resourceName: "nyc12"), #imageLiteral(resourceName: "nyc11"), #imageLiteral(resourceName: "nyc10"), #imageLiteral(resourceName: "nyc9"), #imageLiteral(resourceName: "nyc8"), #imageLiteral(resourceName: "nyc7"),#imageLiteral(resourceName: "nyc6"),#imageLiteral(resourceName: "nyc5"),#imageLiteral(resourceName: "nyc4"),#imageLiteral(resourceName: "nyc3"),#imageLiteral(resourceName: "nyc2"),#imageLiteral(resourceName: "nyc1")]
                 correctAns = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
                 wrongImageArray = toSolveImageArray
            }else if(level == 14){
                toSolveImageArray = [#imageLiteral(resourceName: "la16"), #imageLiteral(resourceName: "la15"), #imageLiteral(resourceName: "la14"), #imageLiteral(resourceName: "la13"), #imageLiteral(resourceName: "la12"), #imageLiteral(resourceName: "la11"), #imageLiteral(resourceName: "la10"), #imageLiteral(resourceName: "la9"), #imageLiteral(resourceName: "la8"), #imageLiteral(resourceName: "la7"),#imageLiteral(resourceName: "la6"),#imageLiteral(resourceName: "la5"),#imageLiteral(resourceName: "la4"),#imageLiteral(resourceName: "la3"),#imageLiteral(resourceName: "la2"),#imageLiteral(resourceName: "la1")]
                 correctAns = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
                 wrongImageArray = toSolveImageArray
            }else if(level == 15){
                toSolveImageArray = [#imageLiteral(resourceName: "a16"), #imageLiteral(resourceName: "a15"), #imageLiteral(resourceName: "a14"), #imageLiteral(resourceName: "a13"), #imageLiteral(resourceName: "a12"), #imageLiteral(resourceName: "a11"), #imageLiteral(resourceName: "a10"), #imageLiteral(resourceName: "a9"), #imageLiteral(resourceName: "a8"), #imageLiteral(resourceName: "a7"),#imageLiteral(resourceName: "a6"),#imageLiteral(resourceName: "a5"),#imageLiteral(resourceName: "a4"),#imageLiteral(resourceName: "a3"),#imageLiteral(resourceName: "a2"),#imageLiteral(resourceName: "a1")]
                 correctAns = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
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
                    if(self.level==11){
                          self.ref?.child("Hard").child("Level11").observeSingleEvent(of: .value, with: { (snapshot) in
                            if snapshot.exists(){
                                         let value = snapshot.value as? NSDictionary
                                             let score = value?["Score"] as! Int
                                             if(score>self.numberOfMoves){
                                                 self.ref?.child("Hard").child("Level11").child("Score").setValue(self.numberOfMoves)
                                             }
                            }else{
                                self.ref?.child("Hard").child("Level11").child("Score").setValue(self.numberOfMoves)
                            }   }){(error)in
                                                        print(error.localizedDescription)
                                                    }
                    }else if(self.level==12){
                       self.ref?.child("Hard").child("Level12").observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists(){
                        let value = snapshot.value as? NSDictionary
                            let score = value?["Score"] as! Int
                            if(score>self.numberOfMoves){
                                self.ref?.child("Hard").child("Level12").child("Score").setValue(self.numberOfMoves)
                            }
                        }else{
                            self.ref?.child("Hard").child("Level12").child("Score").setValue(self.numberOfMoves)
                        }   }){(error)in
                                       print(error.localizedDescription)
                                   }
                    }else if(self.level==13){
                        self.ref?.child("Hard").child("Level13").observeSingleEvent(of: .value, with: { (snapshot) in
                             if snapshot.exists(){
                        let value = snapshot.value as? NSDictionary
                            let score = value?["Score"] as! Int
                            if(score>self.numberOfMoves){
                                self.ref?.child("Hard").child("Level13").child("Score").setValue(self.numberOfMoves)
                            }
                            }else{
                                self.ref?.child("Hard").child("Level13").child("Score").setValue(self.numberOfMoves)
                            }    }){(error)in
                                       print(error.localizedDescription)
                                   }
                    }else if(self.level==14){
                       self.ref?.child("Hard").child("Level14").observeSingleEvent(of: .value, with: { (snapshot) in
                         if snapshot.exists(){
                       let value = snapshot.value as? NSDictionary
                           let score = value?["Score"] as! Int
                           if(score>self.numberOfMoves){
                               self.ref?.child("Hard").child("Level14").child("Score").setValue(self.numberOfMoves)
                           }
                        }else{
                            self.ref?.child("Hard").child("Level14").child("Score").setValue(self.numberOfMoves)
                        }   }){(error)in
                                      print(error.localizedDescription)
                                  }
                    }else if(self.level==15){
                       self.ref?.child("Hard").child("Level15").observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists(){
                        let value = snapshot.value as? NSDictionary
                            let score = value?["Score"] as! Int
                            if(score>self.numberOfMoves){
                                self.ref?.child("Hard").child("Level15").child("Score").setValue(self.numberOfMoves)
                            }
                        }else{
                            self.ref?.child("Hard").child("Level15").child("Score").setValue(self.numberOfMoves)
                        }    }){(error)in
                                       print(error.localizedDescription)
                                   }
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
            wrongAns = Array(0..<16)
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
                self.wrongImageArray.swapAt(start.item, end.item)
                self.wrongAns.swapAt(start.item, end.item)
                self.undoMovesArray.removeLast()
                self.numberOfMoves += 1
                self.lblMoves.text = "Moves: \(self.numberOfMoves)"
            }
        }
        
        //MARK: CollectionView
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 16
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
            return CGSize(width: width/4, height: width/4	)
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

    



