//
//  ViewController.swift
//  Calculator
//
//  Created by claire chang on 2024/3/5.
//
import UIKit

var shouldStartNewNumberInput = false   //表⽰下⼀次按digit按鈕時要開始輸入⼀個新的數字
var pendendingNumber = ""   //按下operator前輸入的數字暫存在這裡

class ViewController: UIViewController {

    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var digitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化數字及運算⼦的狀態
        digitLabel.text = "0"
        operatorLabel.text = " "
    }

    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        
        self.operatorLabel.text = sender.titleLabel?.text   //將 sender button 的⽂字取代 operatorLabel 原有的⽂字
        shouldStartNewNumberInput = true   //已按下運算⼦，下⼀個digit輸入時應該開始新的數字輸入
    }
    @IBAction func digitButtonPressed(_ sender: UIButton) {
        //判斷是否開始新的數字輸入
        if shouldStartNewNumberInput{
            pendendingNumber = digitLabel.text!   //暫存前⼀個輸入的數字
            //初始化數字輸入匡，初始值是0，與viewDidLoad⼀樣
            //剛按下的新的digit在if過後會放到digitLabel
            digitLabel.text = "0"
            
            shouldStartNewNumberInput = false   //開始新的數字輸入了，把flag改回來
        }
        
        if digitLabel.text == "0" && sender.titleLabel?.text != "."{
        digitLabel.text = ""
        }

        if sender.titleLabel?.text == "." && digitLabel.text?.range(of: ".") != nil
        {  return  }
        
        digitLabel.text = digitLabel.text! + sender.titleLabel!.text!   //將 sender button 的⽂字接在 digirLabel的⽂字後⽅
    }
    
    @IBAction func equalButtonPressed(_ sender: Any) {
        //檢查operatorLabel有沒有值，如果是nil或是空字串，則離開function
        guard let operatorString = operatorLabel.text,
        !operatorString.isEmpty
        else {return}
        
        //檢查 pendingNumber 與 digitLabel 的字串可否轉成數字，若不⾏則離開; 若可以轉成數字，unwrap 成 Double 存到 value1, value2
        guard let value1 = Double(pendendingNumber),
        let value2 = Double(digitLabel.text!) else { return}
        
        var result:Double = 0  //暫存計算結果的變數
        
        //根據不同的 operator 做計算
        switch operatorString {
        case "+":
        result = value1 + value2
        case "-":
        result = value1 - value2
        case "x":
        result = value1 * value2
        case "/":
        result = value1 / value2

        default:
        break;
        }
        
        digitLabel.text = "\(result)"   //將計算的結果顯⽰在 digitLabel
        
        operatorLabel.text = ""   //將螢幕上的運算⼦清空
        shouldStartNewNumberInput = true   //按下等號後，下⼀次按Digit為輸入⼀個新的數字(第⼀個運算數字)
    }
    
    @IBAction func allClearButtonPress(_ sender: Any) {
        digitLabel.text = "0"
        operatorLabel.text = ""
        shouldStartNewNumberInput = false
        pendendingNumber = ""
    }
    
    @IBAction func ClearButtonPredd(_ sender: Any) {
        digitLabel.text = "0"
    }
    @IBAction func backButtonPress(_ sender: Any) {
        let length: Int! = digitLabel.text?.count   //取得字數
        
        if length != 0{
            let text: String = digitLabel.text!
            let text1 = text.prefix(length-1)
                        
            digitLabel.text = "\(text1)"
        }
    }
    
    
}

