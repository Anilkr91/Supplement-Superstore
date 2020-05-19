//
//  ImageZoomVC.swift
//  Supplement Superstores
//
//  Created by mac on 10/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Kingfisher

class ImageZoomVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var crossButton: UIButton!
    
    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    var imageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
        if #available(iOS 13, *) {
           hideDismiss()
        } else {
           showDismiss()
            
        }
    }
    
    func hideDismiss() {
        crossButton.isHidden = true
        crossButton.isEnabled = false
        
    }
    
    func showDismiss() {
       crossButton.isHidden = false
        crossButton.isEnabled = true
        crossButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
    }
    
  @objc func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        let vWidth = self.view.frame.width
        let vHeight = self.view.frame.height
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 0.2
        scrollImg.maximumZoomScale = 2.0
        
        
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.view.addSubview(scrollImg)
        self.view.addSubview(crossButton)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: vWidth, height: vHeight))
        
        let resource = ImageResource(downloadURL: imageUrl!, cacheKey: "\(imageUrl!)")
        imageView.kf.setImage(with: resource)
        //imageView.image = UIImage(named: "home_banner.png")
        imageView.contentMode = .scaleAspectFit
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
        
        
    }
    
//    @objc func doneButtonClicked(_ button:UIBarButtonItem!){
//        self.dismiss(animated: true, completion: nil)
//    }
//    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
