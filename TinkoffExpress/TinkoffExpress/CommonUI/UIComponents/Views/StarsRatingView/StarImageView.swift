//
//  StarImageView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 28.05.2023.
//

import UIKit

class StarImageView: UIImageView {
    var rate: Rate = .one

    required convenience init(rate: Rate, image: UIImage) {
        self.init(image: image)

        self.rate = rate
    }

    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
