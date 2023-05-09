//
//  TEOrdersNotificationsService.swift
//  TinkoffExpress
//
//  Created by r.akhmadeev on 09.05.2023.
//

import Foundation

protocol ITEOrdersNotifier {
    func add(listener: ITEOrdersNotificationsListener)
}

protocol ITEOrdersNotificationsListener: AnyObject {
    func didCreateNewOrder()
    func didUpdateOrder()
    func didUpdateOrderWithDelete()
}

final class TEOrdersNotificationsService {
    // MARK: Internal Types

    private final class WeakListener {
        private(set) weak var listener: ITEOrdersNotificationsListener?

        init(listener: ITEOrdersNotificationsListener) {
            self.listener = listener
        }
    }

    // MARK: Singleton implementation

    static let shared = TEOrdersNotificationsService()

    private init() {}

    // MARK: State

    private var listeners: [WeakListener] = []
}

// MARK: - ITEOrdersNotifier

extension TEOrdersNotificationsService: ITEOrdersNotifier {
    func add(listener: ITEOrdersNotificationsListener) {
        listeners.append(WeakListener(listener: listener))
    }
}

// MARK: - ITEOrdersNotificationsListener

extension TEOrdersNotificationsService: ITEOrdersNotificationsListener {
    func didCreateNewOrder() {
        listeners.forEach { $0.listener?.didCreateNewOrder() }
    }

    func didUpdateOrder() {
        listeners.forEach { $0.listener?.didUpdateOrder() }
    }
    
    func didUpdateOrderWithDelete() {
        listeners.forEach { $0.listener?.didUpdateOrderWithDelete() }
    }
}
