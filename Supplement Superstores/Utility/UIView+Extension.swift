//
//  UIView+Extension.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


public extension NSDictionary{
    
    func toJSONString() -> String{
        if JSONSerialization.isValidJSONObject(self) {
            do{
                let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
                
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                print("error")
            }
        }
        return ""
    }
}

struct ActivityIndicator {
    private let spinner = UIActivityIndicatorView(style: .whiteLarge)
        static let shared = ActivityIndicator()
        //var username: String?
        
        private init() { }
        
        
        func hideActivityindicator() {
            
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.removeFromSuperview()
                
            }
        }
        
        func showActivityIndicator(onCenter: Bool, VC: UIViewController) {
                   
                   DispatchQueue.main.async {
                    self.spinner.center = onCenter ? VC.view.center : CGPoint(x: VC.view.center.x , y: 250)
                    self.spinner.hidesWhenStopped = true
                    self.spinner.color = UIColor.init(red: 22/255.0, green: 125/255.0, blue: 210/255.0, alpha: 1)
                      
                       
                    VC.view.addSubview(self.spinner)
                    self.spinner.bringSubviewToFront(VC.view)
                    self.spinner.startAnimating()
                   
            }
        }
}
