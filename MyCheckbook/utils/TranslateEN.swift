//
//  TranslateEN.swift
//  MyCheckbook
//
//  Created by ho on 2017/10/1.
//  Copyright © 2017年 ho. All rights reserved.
//

import Foundation

class TranslateEN
{
    static public func trans(value:Double)->String
    {
        var dollars:String = "";
        var cents:String = "";
        let arr:Array = [" ", " ", " Thousand ", " Million ", " Billion ", " Trillion "];
        
        //小数处理
        let xDecimal:Double = value - Double(Int(value));//判断是否有小数
        if(xDecimal > 0)//如果有整数部分
        {
            cents = getTens(pTens: Int(round(xDecimal*100)));//把2位小数整数化 //小数点*100时候会出现很多0.1999999，保留2位处理
        }
        
        //处理整数部分
        var pNumber:String  = String(Int(value));//获取除小数以外的字符串 //
        
        var xIndex:Int = 1;
        while(pNumber != "")//切整个数字字符串
        {
            if(pNumber.characters.count < 3)//整串小于3个数的时候进行补齐 每次都要补齐
            {
                pNumber = "000" + pNumber;
                pNumber = pNumber.substring(from: pNumber.index(pNumber.endIndex, offsetBy: -3));
            }

            var xHundred:String = ""
            let xValue:String = pNumber.substring(from: pNumber.index(pNumber.endIndex, offsetBy: -3));//获取字符串最右3个数
            if (Int(xValue) != 0)
            {
                let h:String = xValue.substring(to: xValue.index(xValue.startIndex, offsetBy:1));
                let t:String = xValue.substring(from: xValue.index(xValue.endIndex, offsetBy:-2));
                if(h != "0")//百位不为0
                {
                    xHundred = getDigit(pDigit: Int(h)!) + " Hundred ";
                }
                if(t != "0")
                {
                    xHundred += getTens(pTens: Int(t)!) + "";
                }
            }
//          xHundred += getDigit(Mid(xValue, 3))
            if(xHundred != "")//整数部分整合文字
            {
                dollars = xHundred + arr[xIndex] + dollars
            }
        
            if(pNumber.characters.count > 3)//是否要下次while循环
            {
                pNumber = pNumber.substring(to: pNumber.index(pNumber.endIndex, offsetBy: -3));
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
                dollars = "No dollars"
            case "One":
                dollars = "One Dollar"
            default:
                dollars += " dollars"
        }

        switch(cents)
        {
            case "":
                cents = " Only"
            case "One":
                cents = " and One Cent"
            default:
                cents = " and " + cents + " cents"
        }
        let spellNumberToEnglish:String = dollars + cents

        return spellNumberToEnglish;
    }

    static func getTens(pTens:Int)->String//十位数处理
    {
        var result:String = ""
        if (Int(pTens/10) == 1)//如果是10开头
        {
            switch(pTens)
            {
                case 10:
                    result = "Ten";
                case 11:
                    result = "Eleven";
                case 12:
                    result = "Twelve";
                case 13:
                    result = "Thirteen";
                case 14:
                    result = "Fourteen";
                case 15:
                    result = "Fifteen";
                case 16:
                    result = "Sixteen";
                case 17:
                    result = "Seventeen";
                case 18:
                    result = "Eighteen";
                case 19:
                    result = "Nineteen";
                default:
                    //do nothing
                break;
           }
        }
        else //如果不是
        {
            switch(Int(pTens/10))//就看十位上的数字是多少
            {
                case 2:
                    result = "Twenty "
                case 3:
                    result = "Thirty "
                case 4:
                    result = "Forty "
                case 5:
                    result = "Fifty "
                case 6:
                    result = "Sixty "
                case 7:
                    result = "Seventy "
                case 8:
                    result = "Eighty "
                case 9:
                    result = "Ninety "
                default:
                    //do nothing
                    break;
            }
            result += getDigit(pDigit: pTens%10);
        }
        
        return result;
    }


    static func getDigit(pDigit:Int)->String
    {
        var digit:String = "";
        switch(pDigit)
        {
            case 1:
                digit = "One"
                break;
            case 2:
                digit = "Two"
                break;
            case 3:
                digit = "Three"
                break;
            case 4:
                digit = "Four"
                break;
            case 5:
                digit = "Five"
                break;
            case 6:
                digit = "Six"
                break;
            case 7:
                digit = "Seven"
                break;
            case 8:
                digit = "Eight"
                break;
            case 9:
                digit = "Nine"
                break;
            default:
                digit = "";
                break;
        }
        return digit;
    }
}
