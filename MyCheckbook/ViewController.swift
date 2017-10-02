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
    @IBOutlet weak var layCNHeight: NSLayoutConstraint!
    
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
        
        initScreen();
        
        
    }
    
    func initScreen()
    {
        //iphone se 320 568
        //iphone 7 375 667
        //let modelName = device.modelName
        let screenHeight = UIScreen.main.bounds.height;
        if(screenHeight <= 568)
        {
            layCNHeight.constant = 100;
            showEN.font = UIFont.systemFont(ofSize: 14)//14;
            showCN.font = UIFont.systemFont(ofSize: 20)//14;20;
            input.font = UIFont.systemFont(ofSize: 45)//45;
            setBtnFontSize(value: 24);
        }
        else
        {
            layCNHeight.constant = 140;
            showEN.font = UIFont.systemFont(ofSize: 20)//20;
            showCN.font = UIFont.systemFont(ofSize: 24)//24;
            input.font = UIFont.systemFont(ofSize: 60)//60;
            setBtnFontSize(value: 30);
        }

    }
    
    func setBtnFontSize (value:CGFloat){
        btn0.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn4.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn5.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn6.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn7.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn8.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn9.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btn0.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btnDOT.titleLabel?.font = UIFont.systemFont(ofSize: value);
        btnBACKSPACE.titleLabel?.font = UIFont.systemFont(ofSize: value);
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

extension UIDevice {
    
    var modelName: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
