//
//  OrderCheckoutCellType.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.03.2023.
//

import UIKit

enum OrderCheckoutCellType: String {
    case empty
    case whatWillBeDelivered = "orderCheckoutWhatToBring"
    case delivery = "orderCheckoutDelivery"
    case payment = "orderCheckoutPayment"
}
