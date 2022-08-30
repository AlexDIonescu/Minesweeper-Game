//
//  ViewController.swift
//  Minesweeper
//
//  Created by Alex Ionescu on 24.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var taps = 0
    var time = 0
    var timer = Timer()
    let winWords = ["Impressive", "Wow", "You're a genius ?", "Excelent", "That's cool!", "Awesome", "You are untouchable!"]
    let loseWords = ["Too bad", "Not impressive", "Try again", "Not now"]
    let blankWords = ["True detective!", "Mindwblowing!", "It's too easy?", "Sherlock, that's you?", "Wow, impressive!", "Awesome!"]
    let leftBombs = [0, 9, 18, 27, 36, 45, 54, 63, 72]
    let rightBombs = [8, 17, 26, 35, 44, 53, 62, 71, 80]
    let neighbourBombsArray = ["1", "2", "3", "4", "5", "6", "7", "8"]
    var blankGroupLetterArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var currentLetter = 0
    
    func gameLoader() {
        var bombs : [Int] = []
        var result = Int.random(in: 1...10)
        print(result)
        var num = result
        
        for _ in 1..<40 {
            if num <= 80 {
                bombs.append(num)
            } else {
                break
            }
            result = Int.random(in: 1...10)
            num += result
        }
        print(bombs)
        let numberOfBombs = bombs.count
        var counter = 0
        for button in self.buttonsCollection {
            
            if counter < numberOfBombs && button.tag == bombs[counter] {
                button.isEnabled = false
                button.setTitle("💣", for: .disabled)
                button.isEnabled = true
                print("\(button.tag) " + "disabled: " + (button.title(for: .disabled) ?? "-") + "normal: " + (button.title(for: .normal) ?? "-"))
                counter += 1
            }
        }
        
        for button in self.buttonsCollection {
            
            if button.title(for: .disabled) != "💣" {
                neighbourBombs(buttonTag: button.tag, button: button)
            }
            
        }
    }
    
    
    func neighbourBombs( buttonTag : Int, button : UIButton) {
        
        var neighbours = 0
        
        if leftBombs.contains(buttonTag)  {
            
            if buttonTag > 9 && buttonsCollection[buttonTag - 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag > 8 && buttonsCollection[buttonTag - 8].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonsCollection[buttonTag + 1].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 72 && buttonsCollection[buttonTag + 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 72 && buttonsCollection[buttonTag + 10].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            
        } else if rightBombs.contains(buttonTag) {
            
            if buttonTag > 8 && buttonsCollection[buttonTag - 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag > 8 && buttonsCollection[buttonTag - 10].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonsCollection[buttonTag - 1].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 72 && buttonsCollection[buttonTag + 8].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 71 && buttonsCollection[buttonTag + 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            
        } else {
            if buttonTag > 10 && buttonsCollection[buttonTag - 10].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag > 8  && buttonsCollection[buttonTag - 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag > 8 && buttonsCollection[buttonTag - 8].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag > 1 && buttonsCollection[buttonTag - 1].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 80 && buttonsCollection[buttonTag + 1].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 72 && buttonTag > 1 && buttonsCollection[buttonTag + 8].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 71 && buttonsCollection[buttonTag + 9].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
            if buttonTag < 70 && buttonsCollection[buttonTag + 10].title(for: .disabled) ==  "💣" {
                neighbours += 1
            }
        }
        if neighbours == 0 {
            button.setTitle("", for: .disabled)
        } else if neighbours == 1 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.blue, for: .disabled)
        } else if neighbours == 2 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.systemGreen, for: .disabled)
        } else if neighbours == 3 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.red, for: .disabled)
        } else if neighbours == 4 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.systemBlue, for: .disabled)
        } else if neighbours == 5 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.brown, for: .disabled)
        } else if neighbours == 6 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.cyan, for: .disabled)
        } else if neighbours == 7 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.black, for: .disabled)
        } else if neighbours == 8 {
            button.setTitle("\(neighbours)", for: .disabled)
            button.setTitleColor(.gray, for: .disabled)
        }
        print(neighbours)
    }
    
    func play() {
        taps = 0
        for buttons in buttonsCollection {
            buttons.setTitle("", for: .disabled)
            buttons.isEnabled = true
        }
        gameLoader()
    }
    
    
    @IBAction func resetButtonTap(_ sender: UIButton) {
        loaderFunction()
    }
    
    func loaderFunction()  {
        
        for button in self.buttonsCollection {
            
            button.backgroundColor = .systemGray5
            
        }
        time = 0
        taps = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(labelChange), userInfo: nil, repeats: true)
        timerLabel.text = ""
        wordsLabel.text = ""
        play()
        
        var counter = 0
        
        for button in self.buttonsCollection {
            if button.title(for: .disabled) == "" {
                button.setTitle("a", for: .disabled)
                break
            }
        }
        for button in self.buttonsCollection {
            
            if button.title(for: .disabled) == "" {
                
                if button.tag > 8 && buttonsCollection[button.tag - 9].title(for: .disabled) == blankGroupLetterArray[currentLetter]{
                    
                    button.setTitle("\(blankGroupLetterArray[currentLetter])", for: .disabled)
                    
                    print("if 1")
                } else if button.tag > 0 && buttonsCollection[button.tag - 1].title(for: .disabled) == blankGroupLetterArray[currentLetter] && !leftBombs.contains(button.tag) && !rightBombs.contains(button.tag){
                    
                    button.setTitle("\(blankGroupLetterArray[currentLetter])", for: .disabled)
                    print("if 2")
                } else if button.tag < 80 && buttonsCollection[button.tag + 1].title(for: .disabled) == blankGroupLetterArray[currentLetter] && !rightBombs.contains(button.tag) {
                    
                    button.setTitle("\(blankGroupLetterArray[currentLetter])", for: .disabled)
                    print("if 3")
                } else if button.tag > 8 && blankGroupLetterArray.contains(buttonsCollection[button.tag - 9].title(for: .disabled)!) {
                    
                    button.setTitle("\(buttonsCollection[button.tag - 9].title(for: .disabled) ?? "-")", for: .disabled)
                    print("if 4")
                } else if button.tag > 0 && blankGroupLetterArray.contains(buttonsCollection[button.tag - 1].title(for: .disabled)!) && !leftBombs.contains(button.tag){
                    
                    button.setTitle("\(buttonsCollection[button.tag - 1].title(for: .disabled) ?? "-")", for: .disabled)
                    print("if 5")
                } else if button.tag < 80 && blankGroupLetterArray.contains(buttonsCollection[button.tag + 1].title(for: .disabled)!) && !rightBombs.contains(button.tag) {
                    
                    button.setTitle("\(buttonsCollection[button.tag + 1].title(for: .disabled) ?? "-")", for: .disabled)
                    print("if 6")
                } else if button.tag > 7 && !blankGroupLetterArray.contains(buttonsCollection[button.tag - 8].title(for: .disabled) ?? "-") && button.tag < 80 && buttonsCollection[button.tag + 1].title(for: .disabled) == "" {
                    print("if 7")
                    counter = 1
                    break
                    
                } else if button.tag > 7 && blankGroupLetterArray.contains(buttonsCollection[button.tag - 8].title(for: .disabled) ?? "-") &&  button.tag < 80 && buttonsCollection[button.tag + 1].title(for: .disabled) == "" && !rightBombs.contains(button.tag){
                    button.setTitle("\(buttonsCollection[button.tag - 8].title(for: .disabled) ?? "-")", for: .disabled)
                    print("if 8")
                    
                } else if currentLetter < blankGroupLetterArray.count {
                    currentLetter += 1
                    button.setTitle("\(blankGroupLetterArray[currentLetter])", for: .disabled)
                    print("if 9")
                }
            }
            
        }
        
        currentLetter = 0
        
        if counter == 1 {
            loaderFunction()
        }
        
        
    }
    
    
    
    @objc func labelChange(){
        time += 1
        self.timerLabel.text = "\(time)"
        if timerLabel.text == "100" {
            timer.invalidate()
            let alert = UIAlertController(title: "TIME'S UP!", message: "100 SECONDS ALREADY", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "RESET", style: .default, handler: {_ in
                self.loaderFunction()
            }))
            self.present(alert, animated: true)
        }
        
    }
    
    
    
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var wordsLabel: UILabel!
    
    @IBAction func buttonsTap(_ sender: UIButton) {
        sender.isEnabled = false
        taps += 1
        
        if taps == 81 {
            self.timer.invalidate()
            let alert = UIAlertController(title: "You win!", message: "\(winWords.randomElement() ?? "Very Good")", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "RESET", style: .default, handler: {_ in
                self.loaderFunction()
            }))
            self.present(alert, animated: true)
            
            for buttons in buttonsCollection {
                buttons.isEnabled = true
            }
        }
        
        if sender.title(for: .disabled) == "💣" {
            self.timer.invalidate()
            for button in self.buttonsCollection {
                if button.title(for: .disabled) == "💣" {
                    button.isEnabled = false
                }
            }
            let alert = UIAlertController(title: "You lose!", message: "\(loseWords.randomElement() ?? "You touched a bomb!")", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "RESET", style: .default, handler: {_ in
                self.loaderFunction()
            }))
            self.present(alert, animated: true)
            
        }
        
        
        if blankGroupLetterArray.contains(sender.title(for: .disabled) ?? "") {
            wordsLabel.text = blankWords.randomElement()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.wordsLabel.text = ""
            })
            let letter = sender.title(for: .disabled)
            for button in self.buttonsCollection {
                if button.title(for: .disabled) == letter {
                    if button.tag > 8 && neighbourBombsArray.contains(buttonsCollection[button.tag - 9].title(for: .disabled) ?? "") {
                        buttonsCollection[button.tag - 9].isEnabled = false
                    }
                    if button.tag < 72 && neighbourBombsArray.contains(buttonsCollection[button.tag + 9].title(for: .disabled) ?? "") {
                        buttonsCollection[button.tag + 9].isEnabled = false
                    }
                    if button.tag > 0 && !leftBombs.contains(button.tag)  && neighbourBombsArray.contains(buttonsCollection[button.tag - 1].title(for: .disabled) ?? "") {
                        buttonsCollection[button.tag - 1].isEnabled = false
                    }
                    if button.tag < 80 && !rightBombs.contains(button.tag)  && neighbourBombsArray.contains(buttonsCollection[button.tag + 1].title(for: .disabled) ?? "") {
                        buttonsCollection[button.tag + 1].isEnabled = false
                    }
                    button.setTitle("", for: .disabled)
                    button.backgroundColor = .systemGray6
                    button.isEnabled = false
                }
            }
            
        }
        
    }
    
}

