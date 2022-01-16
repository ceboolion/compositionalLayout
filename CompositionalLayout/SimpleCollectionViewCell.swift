//
//  SimpleCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by Roman Cebula on 15/01/2022.
//

import UIKit

class SimpleCollectionViewCell: UICollectionViewCell {
    
    class var reuseIdentifier: String { "SimpleCollectionViewCell" }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
