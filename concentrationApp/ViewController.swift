//  ViewController.swift
//  concentrationApp
//
//  Created by 林祐辰 on 2020/7/21.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var chance: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var popUpStart: UIButton!
    
    var time: Timer? = nil
    var countDownTime = 4
       
    var chanceNum = 14
    
    var successPair = 0
    
    var cards = [Card]()
      
    var pickedCardNum = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleAndShowFirst()
    }

    func shuffleAndShowFirst() -> Void{
        cards.removeAll()
        pickedCardNum.removeAll()
        cards = [Card(cardName: "bird", cardImage: UIImage(named: "bird")),
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
        cards.shuffle()
        showFirst()
    }
    
    func showFirst(){
        
        for (i,_) in cards.enumerated(){
            if(cards[i].canOpen == true && cards[i].hasOpen == false){
                cardButtons[i].setImage(cards[i].cardImage, for: .normal)
            }
        }
        
        if time == nil{
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.firstSeeHelper), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func firstSeeHelper(){
        countDownTime -= 1
        if (countDownTime==0){
        time?.invalidate()
        time = nil
        for (i,_) in cards.enumerated(){
            if(cards[i].hasOpen==false){
                cardButtons[i].setImage(UIImage(named:"qMark"), for: .normal)
                
                UIView.transition(with: cardButtons[i], duration: 0.5, options:.transitionFlipFromLeft, animations: nil, completion: nil)
            }
        }
          
        popUpStart.isHidden = false
        }
        countDown.text = String(countDownTime)
    }
    
    
    func renderCards() -> Void{
        for (i,_) in cardButtons.enumerated(){
            if(cards[i].canOpen){
                if(cards[i].hasOpen){
                    cardButtons[i].setImage(cards[i].cardImage, for: .normal)
                }else{
                    cardButtons[i].setImage(UIImage(named:"qMark"), for: .normal)
                }
            }else{
                cardButtons[i].setImage(cards[i].cardImage, for: .normal)
            }
        }
    }
    
    @IBAction func startPlaying(_ sender: UIButton) {
        popUpStart.isHidden = true
        countDownTime = 60
        countDown.text = String(countDownTime)
        renderCards()
        if(time == nil){
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startPlayingHelper), userInfo: nil, repeats: true)
        }
    }
    
  
    @objc func startPlayingHelper() -> Void {
        countDownTime-=1
        if(countDownTime == 0){
            time?.invalidate()
            failedMission()
      }
        countDown.text = String(countDownTime)
        }

    
    func disableCard(index:Int){
        cards[index].canOpen = false
        cardButtons[index].alpha = 0.3
        UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        
        func cardBeenFliped(index:Int)->Void{
            if(cards[index].hasOpen){
                cardButtons[index].setImage(UIImage(named: "qMark"), for: .normal)
                UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                cards[index].hasOpen = false
            }else{
                cardButtons[index].setImage(cards[index].cardImage, for: .normal)
                UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
                cards[index].hasOpen = true
            }
        }
        
        if let buttonNum = cardButtons.firstIndex(of: sender){
            if(pickedCardNum.count == 0){
                pickedCardNum.append(buttonNum)
                cardBeenFliped(index: buttonNum)
            }else if (pickedCardNum.count == 1){
                chanceNum -= 1
                chance.text = String(chanceNum)
                if(chanceNum==0){
                failedMission()
                }
            
                if pickedCardNum.contains(buttonNum) {
                    pickedCardNum.removeAll()
                }else{
                pickedCardNum.append(buttonNum)
                cardBeenFliped(index:buttonNum)

             if(cards[pickedCardNum[0]].cardName == cards[pickedCardNum[1]].cardName){
           
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.checkedCards), userInfo:nil, repeats: false)
                
             }else if (cards[pickedCardNum[0]].cardName != cards[pickedCardNum[1]].cardName){
                Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) {
                 (_) in for(_,num) in self.pickedCardNum.enumerated() {
                    cardBeenFliped(index: num)
                  }
                 self.pickedCardNum.removeAll()
                   }
             }
    }
            }
        }
        
    }

    @objc func checkedCards(){
        for (_,itemNum)in pickedCardNum.enumerated(){
            self.disableCard(index:itemNum)
        }
        self.successPair += 1
        self.pickedCardNum.removeAll()
        
        if(successPair==8){
            let popSuccess = UIAlertController(title: "恭喜過關", message: "再來一場！", preferredStyle: .alert)
            let successButton = UIAlertAction(title: "來啊來啊", style: .default) { (_) in
            self.restartHelper()
            }
            popSuccess.addAction(successButton)
            present(popSuccess, animated: true, completion: nil)
        }
        
    }

    func failedMission(){
        let alert = UIAlertController(title: "挑戰失敗", message: "再來一次了喔QQ ", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.restartHelper()
        }
        alert.addAction(alertButton)
        present(alert,animated:true,completion:nil)
    }
    
    @IBAction func restart(_ sender: UIButton) {
        restartHelper()
    }
    
    func restartHelper() -> Void{
        popUpStart.isHidden = true
        time?.invalidate()
        time = nil
        shuffleAndShowFirst()
        countDownTime = 4
        countDown.text = String(countDownTime)
        chanceNum = 14
        chance.text = String(chanceNum)
        successPair = 0
        for(i,_) in cardButtons.enumerated(){
            cardButtons[i].alpha = 1
        }
    }
    
}
