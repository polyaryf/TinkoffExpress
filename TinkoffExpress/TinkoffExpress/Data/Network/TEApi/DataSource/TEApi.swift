//
//  TEApi.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 04.04.2023.
//

import Moya

enum TEApi {
    case test
    case getOrders
    case addOrder
    case updateOrder(order: Order)
    case getMyAddresses
    case getAddresses
    case getSlots
}

