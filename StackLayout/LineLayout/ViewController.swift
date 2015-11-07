//
//  ViewController.swift
//  LineLayout
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var imageArray: [String] = {
        
        var array: [String] = []

        for i in 1...20 {
            array.append("\(i)-1")
        }
        
        return array
    }()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView =  UICollectionView(frame: CGRectMake(0, 100, self.view.bounds.width, 200), collectionViewLayout: StackLayout())
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.dataSource  = self
        collectionView.delegate = self
    
        collectionView.registerClass(ImageTextCell.self, forCellWithReuseIdentifier: "ImageTextCell")
        self.view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.collectionView!.collectionViewLayout.isKindOfClass(StackLayout.self) {
            self.collectionView!.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        }else {
            self.collectionView!.setCollectionViewLayout(StackLayout(), animated: true)
        }
        
    }
    
     // MARK: - collectionView代理
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageTextCell", forIndexPath: indexPath) as! ImageTextCell
        cell.imageStr = self.imageArray[indexPath.item]

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.imageArray.removeAtIndex(indexPath.item)
        
        collectionView.deleteItemsAtIndexPaths([indexPath])
    }
}

