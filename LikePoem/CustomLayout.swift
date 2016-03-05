//
//  CustomLayout.swift
//  CollectionDemo
//
//  Created by wyatt on 15/12/27.
//  Copyright © 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

let screenBounds = UIScreen.mainScreen().bounds
// cell 的宽度与高度设置
let itemWidth = screenBounds.width - 120.0
let itemHeith = screenBounds.height - 200.0

class CustomLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        // cell item 尺寸
        self.itemSize = CGSizeMake(itemWidth, itemHeith)
        // 水平滚动
        self.scrollDirection = .Horizontal
        // cell 间距
        self.minimumLineSpacing = 20.0
    }

    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    // 对布局的一些准备工作放在这里
    override func prepareLayout() {
        super.prepareLayout()
        
        // 设置边距，让第一张图片和最后一张图片出现在中间位置
        let inset = (self.collectionView?.bounds.width ?? 0) * 0.5 - self.itemSize.width * 0.5
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
    }
    
    // 允许CollectionView Bounds 显示的边界发生变化，重新进行布局，默认是false
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    // 获取CollectionView的所有Item项，进行相应的处理（移动过程中，控制各个Item的缩放比例）
    // 用来计算rect这个范围内所有的cell的UICollectionViewLayoutAttributes，并返回
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElementsInRect(rect)
        
        // 可见矩形
        var visibleRect = CGRect()
        visibleRect.origin = self.collectionView!.contentOffset
        visibleRect.size = self.collectionView!.frame.size
        
        // 获得collectionVIew中央的X值(即显示在屏幕中央的X)
        let collectionViewCenterX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width / 2
        for attrs in array! {
            //如果不在屏幕上，直接跳过
            if !CGRectIntersectsRect(visibleRect, attrs.frame) {
                continue
            }
            let scale = 1 + 0.05 * ( 1 - abs(attrs.center.x - collectionViewCenterX) / (self.collectionView!.frame.size.width * 0.5))
            attrs.transform = CGAffineTransformMakeScale(scale, scale)
        }
        return array
        
    }
    
    /*
    当UICollectionView停止那一刻ContentOffset的值（控制UICollectionView停止时，有一个Item一定居中显示）
    proposedContentOffset默认的值是CotentOffset
    - parameter proposedContentOffset: 原本collectionView停止滚动那一刻的位置
    - parameter velocity:              滚动速度
    
    - returns: 最终停留的位置
    */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let lastRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView!.frame.width, self.collectionView!.frame.height)
        //获得collectionVIew中央的X值(即显示在屏幕中央的X)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5;
        //这个范围内所有的属性
        let array = self.layoutAttributesForElementsInRect(lastRect)
        
        //需要移动的距离
        var adjustOffsetX = CGFloat(MAXFLOAT);
        for attri in array! {
            if abs(attri.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attri.center.x - centerX;
            }
        }
        
        return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y)
    }
}
