//
//  OrderCheckout.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import Foundation

struct OrderCheckout {
    let whatWillBeDelivered: String
    let deliveryWhen: String
    let deliveryWhere: String
    let paymentMethod: String
    
    init() {
        self.whatWillBeDelivered = "whatWillBeDelivered"
        self.deliveryWhen = "deliveryWhen"
        self.deliveryWhere = "deliveryWhere"
        self.paymentMethod = "paymentMethod"
    }
    
    init(whatWillBeDelivered: String, deliveryWhen: String, deliveryWhere: String, paymentMethod: String) {
        self.whatWillBeDelivered = whatWillBeDelivered
        self.deliveryWhen = deliveryWhen
        self.deliveryWhere = deliveryWhere
        self.paymentMethod = paymentMethod
    }
}
