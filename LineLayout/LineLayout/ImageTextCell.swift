//
//  ImageTextCell.swift
//  LineLayout
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

class ImageTextCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var imageStr: NSString? {
    
        didSet {
            self.imageView!.image = UIImage(named: self.imageStr as! String)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView()
        self.imageView?.layer.borderColor = UIColor.whiteColor().CGColor;
        self.imageView?.layer.borderWidth = 3;
        self.imageView?.layer.cornerRadius = 3;
        self.imageView?.clipsToBounds = true;

        self.addSubview(self.imageView!)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
