//
//  ViewController.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/04/26.
//

import RealmSwift
import UIKit
import SwiftUI

class TableViewController: UITableViewController, EditProtocol, UpdateProtocol {
    
    var data = [Item]()
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        let realm = r.realm
        let currentDate = Int(floor(Date().timeIntervalSince1970)/86400)
        if let lastDate = UserDefaults.standard.object(forKey: "lastDate") as? Int {
            let elapsedDays = currentDate - lastDate
            if elapsedDays > 0 {
                realm.beginWrite()
                for Item in realm.objects(Item.self) {
                    Item.remainingTime -= elapsedDays
                    if Item.remainingTime < 0 {
                        Item.remainingTime = 0
                    }
                }
                try! realm.commitWrite()
            }
        }
        UserDefaults.standard.set(currentDate, forKey: "lastDate")
        if UserDefaults.standard.bool(forKey: "tutorial") == false {
            performSegue(withIdentifier: "showTutorial", sender: nil)
            UserDefaults.standard.set(true, forKey: "tutorial")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = r.realm
        data = realm.objects(Item.self).sorted(by: { $0.remainingTime < $1.remainingTime })
        let theme = UserDefaults.standard.object(forKey: "theme") ?? 1
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "AccentColor\(theme)")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! TableViewCell
        cell.itemLabel.text = data[indexPath.row].name
        cell.progressBar.progress = Float(data[indexPath.row].remainingTime) / Float(data[indexPath.row].period)
        if Float(data[indexPath.row].remainingTime) / Float(data[indexPath.row].period) < 0.5 {
            cell.periodLabelRight.text = "残り\(data[indexPath.row].remainingTime)日"
            cell.periodLabelLeft.text = ""

        } else {
            cell.periodLabelLeft.text = "残り\(data[indexPath.row].remainingTime)日"
            cell.periodLabelRight.text = ""

        }
        cell.editButton.tag = data[indexPath.row].id
        cell.plusButton.tag = data[indexPath.row].id
        cell.minusButton.tag = data[indexPath.row].id
        cell.checkButton.tag = data[indexPath.row].id
        cell.delegate = self
        cell.updateDelegate = self
        if let theme = UserDefaults.standard.object(forKey: "theme") {
            cell.periodFrame.layer.borderColor = UIColor(named: "AccentColor\(theme)")?.cgColor
            cell.progressBar.tintColor = UIColor(named: "AccentColor\(theme)")
            cell.editButton.tintColor = UIColor(named: "AccentColor\(theme)")
            cell.checkButton.tintColor = UIColor(named: "AccentColor\(theme)")
            cell.minusButton.tintColor = UIColor(named: "AccentColor\(theme)")
            cell.plusButton.tintColor = UIColor(named: "AccentColor\(theme)")
            cell.periodLabelRight.textColor = UIColor(named: "AccentColor\(theme)")
        }
        return cell
    }
    
    func catchData(selectedCell: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextStoryboard = storyboard.instantiateViewController(withIdentifier: "EditStoryboard") as! EditViewController
        nextStoryboard.selectedCell = selectedCell
        self.show(nextStoryboard, sender: self)
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}
