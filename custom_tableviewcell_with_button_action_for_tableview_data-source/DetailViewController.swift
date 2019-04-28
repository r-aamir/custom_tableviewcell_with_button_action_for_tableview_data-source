//
//  DetailViewController.swift
//  custom_tableviewcell_with_button_action_for_tableview_data-source
//
//  Created by AamirR on 4/29/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    var item: State!
    
    @objc func openUrl() {
        if let url = URL(string: self.item.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let atStr = NSMutableAttributedString(string: item.title, attributes: [.font : UIFont.boldSystemFont(ofSize: 16)])
        atStr.append(NSAttributedString(string: " " + item.detailText, attributes: [.font : UIFont.systemFont(ofSize: 15)]))
        self.titleLabel.attributedText = atStr

        self.detailLabel.text = item.description

        self.button.addTarget(self, action: #selector(openUrl), for: .touchUpInside)
    }

}
