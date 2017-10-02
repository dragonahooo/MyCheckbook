//
//  ViewController.swift
//  MyCheckbook
//
//  Created by ho on 2017/7/13.
//  Copyright © 2017年 ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var padBg: UIImageView!
    @IBOutlet weak var inputBg: UIImageView!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var btnCancelInput: UIButton!
    @IBOutlet weak var showEN: UITextView!
    @IBOutlet weak var showCN: UITextView!
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btnDOT: UIButton!
    @IBOutlet weak var btnBACKSPACE: UIButton!
    
    var _currentNum:Double = 999999.0;
    var _numStr:String = "0";
    var _dotMode:Bool = false;
    var _dotindex:uint = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorUtils.APP_BG_COLOR;
        
        self.padBg.image = UIImage(named: "number_pad_bg");
        self.inputBg.image = UIImage(named: "number_input_bg");
        self.btnCancelInput.imageView?.image = UIImage(named: "icon_cancel");
        
        initWords();
        
    }
    
    func initWords()
    {
        setNumbers(value: 0.0);
    }
    
    func setNumbers(value:Double)
    {
        if(_currentNum == value)
        {
            return;
        }
        
        _currentNum = value;
        
        if(_currentNum <= 0.0 || _currentNum <= 0)//init
        {
            initUI();
        }
        else
        {
            if(_dotMode && (_currentNum - Double(Int(_currentNum)) > 0.0))
            {
                _numStr = String(_currentNum);
            }
            else{
               
                _numStr = String(Int(_currentNum));
            }
            
            self.btnCancelInput.isHidden = false;
            
            self.showEN.text = TranslateEN.trans(value: _currentNum);
            self.showCN.text = TranslateCN.trans(value: _currentNum);
            
        }
        self.input.text = _numStr;
    }
    
    @IBAction func btnNumberClick(_ sender: UIButton) {
        
        switch(sender)
        {
            case btn0:
                addNum(value: 0);
                break;
            case btn1:
                addNum(value: 1);
                break;
            case btn2:
                addNum(value: 2);
                break;
            case btn3:
                addNum(value: 3);
                break;
            case btn4:
                addNum(value: 4);
                break;
            case btn5:
                addNum(value: 5);
                break;
            case btn6:
                addNum(value: 6);
                break;
            case btn7:
                addNum(value: 7);
                break;
            case btn8:
                addNum(value: 8);
                break;
            case btn9:
                addNum(value: 9);
                break;
            case btnDOT:
                addInput(value: ".");
                break;
            case btnBACKSPACE:
                removeLastStr();
                break;
            case btnCancelInput:
                initWords();
                break;
            default:
                //do nothing
                break;
        }
        
    }
    
    func addNum(value:uint)
    {
        if(!_dotMode)
        {
            if(String(Int(_currentNum * 10 + Double(value))).characters.count > 12)//整数太长会报错 千亿
            {
                return;
            }
            setNumbers(value: _currentNum * 10 + Double(value));
        }
        else
        {
            if(_dotindex > 2)//只限2位小数
            {
                return;
            }
            if(value == 0)
            {
                addInput(value: "0");
            }
            else
            {
                setNumbers(value: _currentNum + Double(value) / pow(10.0, Double(_dotindex)));
            }
            
            _dotindex += 1;
        }
        
    }
    
    func addInput(value: String)
    {
        if(_dotMode && value == ".")//在小数模式中，不能无止尽的加 .
        {
            return;

        }
        if(!_dotMode)
        {
            _dotindex = 1;
            _dotMode = true;

        }
        _numStr += value;
        self.input.text = _numStr;
        self.btnCancelInput.isHidden = false;
    }

    func removeLastStr()
    {
        if(_numStr == "0" || _numStr == "")//不处理 0 的情况
        {
            return;
        }
        if(_numStr.characters.count == 1)//处理 只有1个数的时候，移除都默认置为0
        {
            setNumbers(value: 0.0);
            return;
        }
        
        if(_numStr.characters.last == ".")//当要移除的是小数点 . 的时候，小数点模式为false
        {
            _dotMode = false;
        }
        if(_dotMode)//当为小数点模式时候，每移除一个，dotindex相应-1
        {
            _dotindex -= 1;
        }

        //处理面板显示部分，移除到哪，就显示到哪。
        var newNum:String = "";
        newNum.characters = _numStr.characters.dropLast();
        print(newNum);
        
        //再根据面板显示 反响 附值给_currentNum 并翻译
        _numStr = newNum;
        _currentNum = Double(newNum)!;
        self.input.text = _numStr;
        self.showEN.text = TranslateEN.trans(value: _currentNum);
        self.showCN.text = TranslateCN.trans(value: _currentNum);
        
        //最终为0时使用清空处理
        if(newNum == "0")
        {
            initUI();
        }
        
    }
    
    func initUI()
    {
        _dotMode = false;
        _dotindex = 0;
        _numStr = "0";
        self.btnCancelInput.isHidden = true;
        self.showEN.text = "";
        self.showCN.text = "";
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent;
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}

