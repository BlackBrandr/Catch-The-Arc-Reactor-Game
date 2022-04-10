//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Burak Karataş on 12.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighScoreLabel: UILabel!
    @IBOutlet weak var arc1: UIImageView!
    @IBOutlet weak var arc2: UIImageView!
    @IBOutlet weak var arc3: UIImageView!
    @IBOutlet weak var arc4: UIImageView!
    @IBOutlet weak var arc5: UIImageView!
    @IBOutlet weak var arc6: UIImageView!
    @IBOutlet weak var arc7: UIImageView!
    @IBOutlet weak var arc8: UIImageView!
    @IBOutlet weak var arc9: UIImageView!
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var ArcArray = [UIImageView]()
    var HideTimer = Timer()
    var HighScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreLabel.text = "Score : \(score)"
        
        // High Score Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if storedHighScore == nil {
            HighScore = 0
            HighScoreLabel.text = "High Score : \(HighScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            HighScore = newScore
            HighScoreLabel.text = "High Score : \(HighScore)"
        }
        
        arc1.isUserInteractionEnabled = true
        arc2.isUserInteractionEnabled = true
        arc3.isUserInteractionEnabled = true
        arc4.isUserInteractionEnabled = true
        arc5.isUserInteractionEnabled = true
        arc6.isUserInteractionEnabled = true
        arc7.isUserInteractionEnabled = true
        arc8.isUserInteractionEnabled = true
        arc9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        arc1.addGestureRecognizer(recognizer1)
        arc2.addGestureRecognizer(recognizer2)
        arc3.addGestureRecognizer(recognizer3)
        arc4.addGestureRecognizer(recognizer4)
        arc5.addGestureRecognizer(recognizer5)
        arc6.addGestureRecognizer(recognizer6)
        arc7.addGestureRecognizer(recognizer7)
        arc8.addGestureRecognizer(recognizer8)
        arc9.addGestureRecognizer(recognizer9)
        
        ArcArray = [arc1, arc2, arc3, arc4, arc5, arc6, arc7, arc8, arc9]
             
        counter = 10
        TimerLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerfunc), userInfo: nil, repeats: true)
        HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(HideArc), userInfo: nil, repeats: true)
        
        HideArc()
    }
    
    @objc func HideArc() {
        for Arc in ArcArray {
            Arc.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(ArcArray.count - 1)))
        ArcArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        
        score += 1
        ScoreLabel.text = "Score : \(score)"
        
    }

    @objc func timerfunc() {
        
        TimerLabel.text = "\(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            HideTimer.invalidate()
            
            for Arc in ArcArray {
                Arc.isHidden = true
                }
            
            
            if self.score > self.HighScore {
                self.HighScore = self.score
                HighScoreLabel.text = "High Score : \(self.HighScore) "
                UserDefaults.standard.set(self.HighScore, forKey: "HighScore")
            }
            
       
           // Alert
            
            let alert = UIAlertController(title: "Time is up !", message: "Do you want to replay ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.ScoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.TimerLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerfunc), userInfo: nil, repeats: true)
                self.HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.HideArc), userInfo: nil, repeats: true)

                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
        
        
    



}
