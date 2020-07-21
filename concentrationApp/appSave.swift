//
//  appSave.swift
//  concentrationApp
//
//  Created by 林祐辰 on 2020/7/21.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//


import UIKit
import GameplayKit

struct Card{
    var cardName : String?
    var cardImage : UIImage?
    var canOpen : Bool = true
    var hasOpen : Bool = false
}


var cards = [
    Card(cardName: "bird", cardImage: UIImage(named: "bird")),
    Card(cardName: "bird", cardImage: UIImage(named: "bird")),
    Card(cardName: "cat", cardImage: UIImage(named: "cat")),
    Card(cardName: "cat", cardImage: UIImage(named: "cat")),
    Card(cardName: "cow", cardImage: UIImage(named: "cow")),
    Card(cardName: "cow", cardImage: UIImage(named: "cow")),
    Card(cardName: "dog", cardImage: UIImage(named: "dog")),
    Card(cardName: "dog", cardImage: UIImage(named: "dog")),
    Card(cardName: "fox", cardImage: UIImage(named: "fox")),
    Card(cardName: "fox", cardImage: UIImage(named: "fox")),
    Card(cardName: "fish", cardImage: UIImage(named: "fish")),
    Card(cardName: "fish", cardImage: UIImage(named: "fish")),
    Card(cardName: "kangaroo", cardImage: UIImage(named: "kangaroo")),
    Card(cardName: "kangaroo", cardImage: UIImage(named: "kangaroo")),
    Card(cardName: "squirrel", cardImage: UIImage(named: "squirrel")),
    Card(cardName: "squirrel", cardImage: UIImage(named: "squirrel")),
]

