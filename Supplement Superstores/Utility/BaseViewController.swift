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
        
        
    }
    
    func rightButtonItems(isenabled: Bool) {
        
        if isenabled == true {
            if (self.navigationItem.rightBarButtonItem == nil) {
                let button1 = UIBarButtonItem(image: UIImage(named: "supermarket.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightCartButtonPressed))
                let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightProfileButtonPressed))

                self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
                self.navigationItem.rightBarButtonItem!.tag = 100
            }
        } else {
            return
        }
    }
    
}

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        

    }
    
    
    func rightButtonItems(isenabled: Bool) {
        
        if isenabled == true {
            if (self.navigationItem.rightBarButtonItem == nil) {
                let button1 = UIBarButtonItem(image: UIImage(named: "supermarket.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightCartButtonPressed))
                let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightProfileButtonPressed))

                self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
                self.navigationItem.rightBarButtonItem!.tag = 100
            }
        } else {
            return
        }
    }
}

class BaseCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    func rightButtonItems(isenabled: Bool) {
        
        if isenabled == true {
            if (self.navigationItem.rightBarButtonItem == nil) {
                let button1 = UIBarButtonItem(image: UIImage(named: "supermarket.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightCartButtonPressed))
                let button2 = UIBarButtonItem(image: UIImage(named: "user.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(UIViewController.rightProfileButtonPressed))

                self.navigationItem.setRightBarButtonItems([button1,button2], animated: true)
                self.navigationItem.rightBarButtonItem!.tag = 100
            }
        } else {
            return
        }
    }
    
    
    
}

extension UIViewController {
    
    @IBAction func rightCartButtonPressed(_ button: UIButton) {
             
    }
    
    @IBAction func rightProfileButtonPressed(_ button: UIButton) {
             
    }
}
