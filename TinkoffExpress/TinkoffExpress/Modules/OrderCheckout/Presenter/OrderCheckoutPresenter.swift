//
//  OrderCheckoutPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol OrderCheckoutPresenterProtocol {
    func viewDidLoad()
    func checkoutButtonTapped()
    func backButtonTapped()
}

class OrderCheckoutPresenter: OrderCheckoutPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: OrderCheckoutViewController?
    private var coordinator: Coordinator?
    private var service: OrderCheckoutService?
    
    // MARK: Init
    
    init(coordinator: Coordinator, service: OrderCheckoutService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service?.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }

    // MARK: Events
    
    func checkoutButtonTapped() {
        showFinalDelivery()
    }
    
    func backButtonTapped() {
        showMeetingAppointment()
    }
    
    // MARK: Navigation
    
    private func showFinalDelivery() {
        coordinator?.move(FinalDeliveryAssembly(), with: .push)
    }
    
    private func showMeetingAppointment() {
        // TODO: coordinator?.move(MeetingAppointmentAssembly(), with: .pop)
    }
}
