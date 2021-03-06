//
//  Tutorial4ViewController.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/05/03.
//

import UIKit

class TutorialFourthViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI調整
        cardView.layer.cornerRadius = 20
        startButton.layer.cornerRadius = 20
        circleView.layer.cornerRadius = 400
        cardView.setShadow()
        startButton.setShadow()
    }
    //テーマカラーを反映
    override func viewWillAppear(_ animated: Bool) {
        listImageView.tintColor = ThemeModel.color
        backgroundView.backgroundColor = ThemeModel.color
        startButton.backgroundColor = ThemeModel.color
        circleView.backgroundColor = ThemeModel.color
    }
    //チュートリアルを閉じる
    @IBAction func startAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
