//
//  ViewViewController.swift
//  listToDo
//
//  Created by ios on 10/12/21.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController {

    public var item: ToDoListItem?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter =
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))

    }
@objc private func didTapDelete()
{
    guard let item = self.item else {
        return
    }
    realm.beginWrite()
    realm.delete(item)
    try! realm.commitWrite()
    
    deletionHandler?()
    
    navigationController?.popToRootViewController(animated: true)
}


}
