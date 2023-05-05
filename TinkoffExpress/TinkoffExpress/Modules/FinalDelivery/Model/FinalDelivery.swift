//
//  FinalDelivery.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 28.04.2023.
//

import Foundation

struct FinalDelivery {
    let `where`: String
    let when: String
    let what: String
    
    init() {
        self.where = ""
        self.when = ""
        self.what = ""
    }
    
    init(where: String, when: String, what: String) {
        self.where = `where`
        self.when = when
        self.what = what
    }
}
