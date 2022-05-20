//
//  TableViewCell.swift
//  RestockList
//
//  Created by Musa Yazuju on 2022/04/26.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {

    @IBOutlet weak var periodLabelLeft: UILabel!
    @IBOutlet weak var periodLabelRight: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemFrame: UIView!
    @IBOutlet weak var periodFrame: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
<<<<<<< HEAD:RestockList/Model/TableViewCell.swift
    var data = [Item]()
    var editUIViewController = EditViewController()
    var myTableViewController = TableViewController()
=======
    var data = [TableViewItem]()
    let realm = try! Realm()
    var editUIViewController = EditUIViewController()
    var myViewController = ViewController()
>>>>>>> main:RestockList/TableViewCell.swift
    var delegate : EditProtocol?
    var updateDelegate: UpdateProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemFrame.layer.cornerRadius = 15
        periodFrame.layer.borderWidth = 3
        periodFrame.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 10)
        let realm = r.realm
        data = realm.objects(Item.self).sorted(by: { $0.remainingTime < $1.remainingTime })
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.catchData(selectedCell: sender.tag)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        let realm = r.realm
        if realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.remainingTime < realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.period {
            realm.beginWrite()
            realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.remainingTime += 1
            try! realm.commitWrite()
            updateDelegate?.updateTableView()
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        let realm = r.realm
        if realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.remainingTime > 0 {
            realm.beginWrite()
            realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.remainingTime -= 1
            try! realm.commitWrite()
            updateDelegate?.updateTableView()
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        let realm = r.realm
        realm.beginWrite()
        realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.remainingTime = realm.object(ofType: Item.self, forPrimaryKey: sender.tag)!.period
        try! realm.commitWrite()
        updateDelegate?.updateTableView()
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
        
}
