//
//  FYString.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

extension String {
    //是否是有效的电话号码
    func isValidMobileNumber() -> Bool {
        let mobile = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9]|9[8])\\d{8}$"
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|6[6]|7[08]|8[2-478])\\d{8}$";
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56]|9[9])\\d{8}$"
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        let regextestMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestCM = NSPredicate(format: "SELF MATCHES %@", CM)
        let regextestCT = NSPredicate(format: "SELF MATCHES %@", CT)
        let regextestPHS = NSPredicate(format: "SELF MATCHES %@", PHS)
        let regextestCU = NSPredicate(format: "SELF MATCHES %@", CU)
        if (regextestMobile.evaluate(with: self) == true) ||
            regextestCM.evaluate(with: self) == true ||
            regextestCT.evaluate(with:self) == true ||
            regextestCU.evaluate(with: self) == true ||
            regextestPHS.evaluate(with: self) == true {
            return true
        }
        return false
    }
    //是否是有效的银行卡
    func isValidBankCardNumber() -> Bool {
        let BANKCARD = "^(\\d{16}|\\d{19})$";
        let predicate = NSPredicate(format: "SELF MATCHES %@", BANKCARD)
        return predicate.evaluate(with: self)
    }
    
    //是否是有效的邮箱
    func isValidEmail() -> Bool {
        let emailRegex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
}

class FYString: NSObject {

}
