//
//  UIViewExtension.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/06/06.
//

import UIKit

extension UIView {
    //影を追加
    func setShadow() {
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowColor = R.color.fontColor()?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }
}
