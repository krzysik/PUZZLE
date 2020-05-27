//
//  Scores.swift
//  Puzzle
//
//  Created by Patryk Cygan on 26/05/2020.
//  Copyright © 2020 Pollock. All rights reserved.
//

import Foundation

class Scores {
    var key: String
    var score: String
    
    init(dictionary: (AnyObject), key: String){
        self.key = key
        self.score = dictionary["score"] as! String
    }
}
