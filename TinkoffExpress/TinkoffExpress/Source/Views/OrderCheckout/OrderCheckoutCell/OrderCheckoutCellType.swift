//
//  OrderCheckoutCellType.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

extension OrderCheckoutTableViewCell {
    enum OrderCheckoutCellType: String {
        case empty
        case whatWillBeDelivered = "Что привезем"
        case delivery = "Доставка"
        case payment = "Оплата"
    }
}
