//
//  MyColor.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/27.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

//import Foundation
import UIKit

class MyColor: UIColor {
      class var peach: UIColor {
        return UIColor(red: 238/255, green: 143/255, blue: 143/255, alpha: 1)
      }

      // UIColorに登録されている色と名前がかぶっているものはoverrideすればOK
      override class var black: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 17.0 / 255.0, blue: 17.0 / 255.0, alpha: 1.0)
      }
    
    override class var white: UIColor {
      return UIColor(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
    }
}
