//
//  OrderCheckoutModuleType.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 05.05.2023.
//

import Foundation

enum OrderCheckoutModuleType {
    case creatingOrder(NewOrderInputModel)
    case editingOrder(TEApiOrder)
}
