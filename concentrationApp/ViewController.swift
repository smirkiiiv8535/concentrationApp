//  ViewController.swift
//  concentrationApp
//
//  Created by 林祐辰 on 2020/7/21.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var countDown: UILabel! // 時間的Label
    @IBOutlet weak var chance: UILabel! // 次數的Label
    @IBOutlet var cardButtons: [UIButton]! //所有按鈕
    @IBOutlet weak var popUpStart: UIButton!  // 開始遊戲的彈跳鈕
    
    var time: Timer?   // 倒數計時器
    var countDownTime = 4   // 計時器預設時間
       
    var chanceNum = 14 // 可翻牌的次數
    
    var successPair = 0 // 總共8 對 ,一開始0對
    
    var cards = [Card]()  //蒐集卡的集合
    var pickedCardNum = [Int]() // 比對編號的集合
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleAndShowFirst()
    }

    // 在載入時 ,預防會有意外(系統沒渲染好的情況發生) ,所以都先將元素都移除,然後在洗牌渲染至畫面上
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
        showFirst() // 洗牌後, 顯示洗牌結果
    }
    
      
    func showFirst(){
        
         // 將所有洗牌結果都顯示出來
        for (i,_) in cards.enumerated(){
            if(cards[i].canOpen == true && cards[i].hasOpen == false){
                cardButtons[i].setImage(cards[i].cardImage, for: .normal)
            }
        }
        
        
        if time == nil{
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.firstSeeHelper), userInfo: nil, repeats: true)
        }
        
    }
    
    // 提示的４秒已經到了, 會運行以下firstSeeHelper()程式碼
    @objc func firstSeeHelper(){
        countDownTime -= 1
        if (countDownTime==0){
        time?.invalidate()  // 時間到了,停止計時器
        time = nil
        for (i,_) in cards.enumerated(){
            if(cards[i].hasOpen==false){
                cardButtons[i].setImage(UIImage(named:"qMark"), for: .normal)  // 時間到了,將牌設回蓋住的狀態
                
                UIView.transition(with: cardButtons[i], duration: 0.5, options:.transitionFlipFromLeft, animations: nil, completion: nil)
            }
        }
          
        popUpStart.isHidden = false  // 顯示開始遊戲的彈跳鈕
        }
        countDown.text = String(countDownTime)
    }
    
    
    
    // 以下的程式碼的有些順序比較容易會錯亂掉 所以會適度用A,B.. 來表示順序
    
    
    
  // B. 依照卡片是否已經成對 / 是否可以翻來決定按鈕該顯示的樣子
    func renderCards() -> Void{
        for (i,_) in cardButtons.enumerated(){
            // 已成對, 將成對的圖片渲染至畫面
            if(cards[i].canOpen){
                 // 沒有成對, 那檢查卡片有沒有被翻過
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
    
    //  Ａ. 按下開始遊戲的彈跳鈕,會做的動作
    @IBAction func startPlaying(_ sender: UIButton) {
        popUpStart.isHidden = true
        countDownTime = 60
        countDown.text = String(countDownTime)
        renderCards()
        if(time == nil){
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startPlayingHelper), userInfo: nil, repeats: true)
        }
    }
    
  // C. 遊戲開始,計時器開始紀錄,如果時間到會出現彈跳視窗
    @objc func startPlayingHelper() -> Void {
        countDownTime-=1
        if(countDownTime == 0){
            failedMission()
      }
        countDown.text = String(countDownTime)
        }

    
    // Ｄ.翻牌動作
    @IBAction func flipCard(_ sender: UIButton) {
    // D-2.  依照卡片是否有被翻過而做不同的翻牌動作
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
        
   // D-1. 取挑中卡片元素的編號 ,儲存buttonNum到變數中
        if let buttonNum = cardButtons.firstIndex(of: sender){
            //  將卡片的編號放到比對編號的集合, 一開始一定沒有
            if(pickedCardNum.count == 0){
                pickedCardNum.append(buttonNum) // 那就把編號所對應的卡片放到集合中
                cardBeenFliped(index: buttonNum) // 然後做D-2 的動作
            }else if (pickedCardNum.count == 1){
                chanceNum -= 1
                chance.text = String(chanceNum)
                if(chanceNum==0){
                failedMission()
                }
              
                pickedCardNum.append(buttonNum)
                cardBeenFliped(index:buttonNum)

                // 如果編號內第一個元素名稱跟第二個名稱一樣, 會跑到流程Ｅ.
             if(cards[pickedCardNum[0]].cardName == cards[pickedCardNum[1]].cardName){
           
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.checkedCards), userInfo:nil, repeats: false)
                
             }else if (cards[pickedCardNum[0]].cardName != cards[pickedCardNum[1]].cardName){
                
                // (D-2 有撰寫如果卡已經被翻過, 就會將卡翻回去)
                
                Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) {
                    
                 (_) in for(_,num) in self.pickedCardNum.enumerated() {
                    cardBeenFliped(index: num)
                  }
                 self.pickedCardNum.removeAll() // 將比對編號集合內的元素移除, 以便能重新比對
                   }
             }
    
            }
        }
        
    }

    // E-1. 配對成功後,要讓卡不能被點選 ,透明度遞減
      func disableCard(index:Int){
          cards[index].canOpen = false
          cardButtons[index].alpha = 0.3
          UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
      }
      
    
    // E. 配對成功的動作
    @objc func checkedCards(){
        for (_,itemNum)in pickedCardNum.enumerated(){
            self.disableCard(index:itemNum)
        }
        self.successPair += 1   //配對數＋１
        self.pickedCardNum.removeAll()  // 並且將比對編號集合內的元素拿掉
        
        // E-2 . 如果 8對都配對成功了,顯示出彈跳視窗
        if(successPair==8){
            time?.invalidate()
            time = nil
            let popSuccess = UIAlertController(title: "恭喜過關", message: "再來一場！", preferredStyle: .alert)
            let successButton = UIAlertAction(title: "來啊來啊", style: .default) { (_) in
            self.restartHelper()
            }
            popSuccess.addAction(successButton)
            present(popSuccess, animated: true, completion: nil)
        }
        
    }
    
    
// 如果時間到或是超過可點擊次數後 會出現的彈跳視窗
    
    func failedMission(){
        time?.invalidate()
        time = nil
        let alert = UIAlertController(title: "挑戰失敗", message: "再來一次了喔QQ ", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Restart", style: .default) { (_) in
            self.restartHelper()
        }
        alert.addAction(alertButton)
        present(alert,animated:true,completion:nil)
    }
    
  // 重玩按鈕
    @IBAction func restart(_ sender: UIButton) {
        restartHelper()
    }
    
 // 因為會重複使用,所以另外寫一個函式出來
    
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
