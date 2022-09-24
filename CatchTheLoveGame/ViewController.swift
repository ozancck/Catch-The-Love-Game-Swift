//
//  ViewController.swift
//  CatchTheLoveGame
//
//  Created by Ozan Çiçek on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var loveTimer = Timer()
    var highScore = 0
    
    var loveArray = [UIImageView]()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var love1: UIImageView!
    @IBOutlet weak var love2: UIImageView!
    @IBOutlet weak var love3: UIImageView!
    @IBOutlet weak var love4: UIImageView!
    @IBOutlet weak var love5: UIImageView!
    @IBOutlet weak var love6: UIImageView!
    @IBOutlet weak var love7: UIImageView!
    @IBOutlet weak var love8: UIImageView!
    @IBOutlet weak var love9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        scoreLabel.text = "Score: \(score) "
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        love1.isUserInteractionEnabled = true
        love2.isUserInteractionEnabled = true
        love3.isUserInteractionEnabled = true
        love4.isUserInteractionEnabled = true
        love5.isUserInteractionEnabled = true
        love6.isUserInteractionEnabled = true
        love7.isUserInteractionEnabled = true
        love8.isUserInteractionEnabled = true
        love9.isUserInteractionEnabled = true
        
        let reongizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reongizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        love1.addGestureRecognizer(reongizer1)
        love2.addGestureRecognizer(reongizer2)
        love3.addGestureRecognizer(reongizer3)
        love4.addGestureRecognizer(reongizer4)
        love5.addGestureRecognizer(reongizer5)
        love6.addGestureRecognizer(reongizer6)
        love7.addGestureRecognizer(reongizer7)
        love8.addGestureRecognizer(reongizer8)
        love9.addGestureRecognizer(reongizer9)
        
        loveArray = [love1, love2, love3, love4, love5, love6, love7, love8, love9]
        
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        loveTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hideLove), userInfo: nil, repeats: true)
        
        hideLove()
        
        
    }
    
    @objc func hideLove (){
        
        for love in loveArray {
            love.isHidden = true
        }
        
        
        let random = Int(arc4random_uniform(UInt32(loveArray.count - 1)) )
        loveArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore(){
        score+=1
        scoreLabel.text = "Score: \(score) "
    }
    
    @objc func countDown(){
        counter-=1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            loveTimer.invalidate()
            
            for love in loveArray {
                love.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time is up!", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score) "
                
                self.counter = 10
                self.timeLabel.text = String (self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.loveTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.hideLove), userInfo: nil, repeats: true)
                
            }
            
            
            alert.addAction(okButton)
            alert.addAction(replay)
            self.present(alert, animated: true)
        }
    }

}

