//
//  AddViewController.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/04/26.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
        
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBackground: UIView!
    @IBOutlet weak var periodPickerView: UIPickerView!
    
    private let periodArray = ([Int])(1...365)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate
        nameTextField.delegate = self
        periodPickerView.dataSource = self
        periodPickerView.delegate = self
        //UI調整
        textFieldBackground.layer.cornerRadius = 10
        textFieldBackground.layer.opacity = 0.1
        addButton.layer.cornerRadius = 20
        addButton.setShadow()
        //TextField自動フォーカス
        nameTextField.becomeFirstResponder()
        //背景タップ時にキーボード閉じる
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    //テーマカラーを反映
    override func viewWillAppear(_ animated: Bool) {
        addButton.backgroundColor = ThemeModel.color
        textFieldBackground.backgroundColor = ThemeModel.color
    }
    //アイテムをrealmデータに追加
    @IBAction func addAction(_ sender: Any) {
        guard !nameTextField.text!.isEmpty else {
            nameTextField.placeholder = R.string.localizable.namePlaceholder()
            return
        }
        RealmModel.addExpendable(name: nameTextField.text!, period: periodPickerView.selectedRow(inComponent: 0) + 1)
        navigationController?.popViewController(animated: true)
    }

}
//決定ボタンでキーボードを閉じる
extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        return true
    }
}
//Picker関連
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //Pickerの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Pickerの行の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periodArray.count
    }
    //Pickerの選択項目
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(periodArray[row])
    }
}
