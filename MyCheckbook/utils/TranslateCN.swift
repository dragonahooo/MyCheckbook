//
//  TranslateCN.swift
//  MyCheckbook
//
//  Created by ho on 2017/10/1.
//  Copyright © 2017年 ho. All rights reserved.
//

import Foundation


class TranslateCN
{
    
    static let arr:Array = ["", "万", "亿"];
    static let digitArr:Array = ["","壹","贰", "叁", "肆", "伍", "陆", "柒", "捌","玖"];
    
    static public func trans(value:Double)->String
    {
//        print(String(value) + "shu")
        var dollars:String = "";
        var cents:String = "";
        
        //小数处理
        let xDecimal:Double = value - Double(Int(value));//判断是否有小数
//        print(String(xDecimal) + "xiaoshu")

        if(xDecimal > 0)//如果有整数部分
        {
            cents = getXiaoshu(pTens: Int(round(xDecimal*100)));//把2位小数整数化 //小数点*100时候会出现很多0.1999999，保留2位处理
//            print(cents + "xiaoshu")
        }
        
        //处理整数部分
        var pNumber:String  = String(Int(value));//获取除小数以外的字符串 //
//        print(pNumber + "zhengshu")
        
        var xIndex:Int = 0;
        while(pNumber != "")//切整个数字字符串
        {
            if(pNumber.characters.count < 4)//整串小于4个数的时候进行补齐
            {
                pNumber = "0000" + pNumber;
                pNumber = pNumber.substring(from: pNumber.index(pNumber.endIndex, offsetBy: -4));
//                print(pNumber + "令zheng")
            }

            var xQian:String = ""
            let xValue:String = pNumber.substring(from: pNumber.index(pNumber.endIndex, offsetBy: -4));//获取字符串最右4个数
//            print(xValue + "四个")
            if (Int(xValue) != 0)
            {
                let q:Int = Int(Int(xValue)!/1000);
                let h:Int = Int((Int(xValue)! - q*1000)/100);
                let t:Int = Int(Int(xValue)! - q*1000 - h*100);
                if(q != 0)//千位不为0
                {
//                    print(String(q) + "q")
                    xQian = getDigit(pDigit: q) + "仟";
                }
                if(h != 0)//百位不为0
                {
//                    print(String(q) + "b")
                    xQian += getDigit(pDigit: h) + "佰";
                }
                if(t != 0)
                {
//                    print(String(q) + "s")
                    xQian += getTens(pTens: t);
                }
            }
            if(xQian != "")//整数部分整合文字
            {
                dollars = xQian + arr[xIndex] + dollars
            }
            
            if(pNumber.characters.count > 4)//是否要下次while循环
            {
                pNumber = pNumber.substring(to: pNumber.index(pNumber.endIndex, offsetBy: -4));
            }
            else
            {
                pNumber = ""
            }
            xIndex += 1
        }
        
        switch(dollars)
        {
            case "":
                dollars = "零圆";
                break;
            case " ":
                dollars = "零圆";
                break;
            default:
                dollars += "圆";
                break;
        }
        
        switch(cents)
        {
            case "":
                cents = "整";
                break;
            default:
                //
                break;
        }
        let spellNumberToEnglish:String = dollars + cents
        
        return spellNumberToEnglish;
    }
    
    static func getTens(pTens:Int)->String//十位数处理
    {
        var s:String = getDigit(pDigit: pTens/10);
        s = s == "" ? "" : s + "拾";
        return s + getDigit(pDigit: pTens%10);
    }
    
    static func getXiaoshu(pTens:Int)->String//小数位数处理
    {
        var s:String = getDigit(pDigit: pTens/10);
        s = s == "" ? "" : s + "角";
        var g:String = getDigit(pDigit: pTens%10);
        g = g == "" ? "" : g + "分";
        return s + g;
    }
    
    static func getDigit(pDigit:Int)->String
    {
        return digitArr[pDigit];
    }

}
