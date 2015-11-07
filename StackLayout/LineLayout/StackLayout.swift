//
//  StackLayout.swift
//  LineLayout
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

class StackLayout: UICollectionViewLayout {
    
    let itemW: CGFloat = 100
    let itemH: CGFloat = 100
    //在继承自UICollectionViewFlowLayout时，苹果已经帮我们声明了这个属性
    var itemSize: CGSize

    //界面上需要显示的cell的个数
    let showItemNumber: Int = 5
    //角度
    let angles: [CGFloat]  = [0, 0.2, -0.5, 0.2, 0.5]
    
    override init() {
        itemSize = CGSizeMake(itemW, itemH)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 因为这种布局期显示的边界从未发生变化，所以这里的返回值不会对程序产生什么影响
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        print(newBounds)
        return false
    }
    

    /**
    如果实现这个方法，在动态切换布局的时候会报Assertion failure in -[UICollectionViewData layoutAttributesForItemAtIndexPath:]错误。
    这个方法是返回NSIndexPath这个位置的UICollectionViewLayoutAttributes
    */
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {

        let attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        // 只为我们所需要显示的cell设置UICollectionViewLayoutAttributes，虽然说在layoutAttributesForElementsInRect已经判断过indexPath.item < showItemNumber(并且通过代码传进来的i是小于showItemNumber)，但这里任然是需要继续判断，因为在某些情况(删除了一个cell、通过其他方式修改了UICollectionView布局)会导致indexPath.item大于我们自己传递的值，也就是说，系统有其他方式会在我们不知道的情况下调用这个方法。
//        print(indexPath.item)
        if indexPath.item < showItemNumber {
            attr.center = CGPointMake(self.collectionView!.frame.width * 0.5, self.collectionView!.frame.height * 0.5)
            attr.size = itemSize
            attr.transform = CGAffineTransformMakeRotation(angles[indexPath.item])
            //让第一张显示在最上面
            attr.zIndex = self.collectionView!.numberOfItemsInSection(0) - indexPath.item
            attr.hidden = false
        }else {
            attr.hidden = true
        }
        
        return attr
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        print("layoutAttributesForElementsInRect")
        var attrArray: [UICollectionViewLayoutAttributes] = []
        
        //为需要显示的cell创建UICollectionViewLayoutAttributes,这里设置的是显示5个
        for i in 0..<showItemNumber {
            let attr = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))!
            attrArray.append(attr)
        }
        
        return attrArray
    }
    
}
