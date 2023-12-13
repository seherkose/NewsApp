//
//  UIHelper.swift
//  NewsApp
//
//  Created by Seher Köse on 8.09.2023.
//

import UIKit

struct UIHelper{
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat  = 8
        let minimumItemSpacing: CGFloat = 20
        let availableWidth = width - (padding) - (minimumItemSpacing)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.collectionView?.backgroundColor = .beige
        flowLayout.sectionInset = UIEdgeInsets(top: padding + 20 , left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 100)
        
        return flowLayout
    }
}
