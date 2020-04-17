//
//  BaseViewController.swift
//  Supplement Superstores
//
//  Created by mac on 17/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if (self.navigationItem.rightBarButtonItem == nil) {
            let button1 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightOptionButtonPressed(_:)))
            let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightSearchButtonPressed(_:)))

            self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
            self.navigationItem.rightBarButtonItem!.tag = 100
        }
    }
}

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if (self.navigationItem.rightBarButtonItem == nil) {
            let button1 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightOptionButtonPressed(_:)))
            let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightSearchButtonPressed(_:)))

            self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
            self.navigationItem.rightBarButtonItem!.tag = 100
        }
    }
}

class BaseCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if (self.navigationItem.rightBarButtonItem == nil) {
            let button1 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightOptionButtonPressed(_:)))
            let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightSearchButtonPressed(_:)))

            self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
            self.navigationItem.rightBarButtonItem!.tag = 100
        }
    }
}

extension UIViewController {
    
    @IBAction func rightSearchButtonPressed(_ button: UIButton) {
             
    }
    
    @IBAction func rightOptionButtonPressed(_ button: UIButton) {
             
    }
}
