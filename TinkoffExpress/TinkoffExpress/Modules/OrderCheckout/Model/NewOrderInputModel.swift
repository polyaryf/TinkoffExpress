//
//  NewOrderInputModel.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 09.05.2023.
//

import Foundation

struct NewOrderInputModel {
    let address: String
    let deliverySlot: TEApiTimeSlot
    let comment: String
}
