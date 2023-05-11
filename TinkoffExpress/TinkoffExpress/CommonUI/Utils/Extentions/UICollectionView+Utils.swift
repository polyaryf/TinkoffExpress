//
//  UICollectionView+Utils.swift
//  TinkoffExpress
//
//  Created by Руслан Ахмадеев on 06.05.2023.
//

import UIKit

extension UICollectionView {
    func register(_ cellTypes: UICollectionViewCell.Type...) {
        cellTypes.forEach {
            register($0, forCellWithReuseIdentifier: "\($0)")
        }
    }
    
    func dequeue<Cell: UICollectionViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withReuseIdentifier: "\(cellType)", for: indexPath) as! Cell
    }
}
