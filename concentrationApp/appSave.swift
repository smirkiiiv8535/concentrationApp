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
    var cardName : String?     // 卡片名, 後續比對時會使用
    var cardImage : UIImage?   // 卡片的圖
    var canOpen : Bool = true   //  紀錄卡片是否已經成對
    var hasOpen : Bool = false  //  紀錄卡片是否能被翻
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

