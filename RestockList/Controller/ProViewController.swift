//
//  ProViewController.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/05/02.
//

import UIKit

class ProViewController: UIViewController {

    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet var iconBackground: [UIView]!
    @IBOutlet var productImage: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI調整
        iconBackground.forEach{ $0.layer.cornerRadius = 15 }
        productImage.forEach{ $0.layer.cornerRadius = 20 }
        purchaseButton.layer.cornerRadius = 20
        restoreButton.layer.cornerRadius = 20
        purchaseButton.setShadow()
        restoreButton.setShadow()
    }
    //テーマカラーを反映
    override func viewWillAppear(_ animated: Bool) {
        iconBackground.forEach{ $0.backgroundColor = ThemeModel.color }
        purchaseButton.backgroundColor = ThemeModel.color
    }
    //内課金アイテムを購入
    @IBAction func purchaseAction(_ sender: UIButton) {
        PurchaseModel.purchase(view: self)
    }
    //購入した内課金アイテムを復元
    @IBAction func restoreAction(_ sender: UIButton) {
        PurchaseModel.restore(view: self)
    }
}
