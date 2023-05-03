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
    private let service: OrderCheckoutService
    
    // MARK: Init
    
    init(service: OrderCheckoutService) {
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service.loadItems { [weak self] items in
            guard let self = self else { return }
            self.view?.items = items ?? []
        }
    }

    // MARK: Events
    
    func checkoutButtonTapped() {
        //let request = mapper.toOrderCreateRequset(output.getOrderDetail())
        let request = OrderCreateRequest(
            address: TEApiAddress(address: "", lat: 0, lon: 0),
            paymentMethod: "CARD",
            deliverySlot: TEApiTimeSlot(date: "", timeFrom: "", timeTo: ""),
            items: [],
            comment: "",
            status: ""
        )
        view?.startButtonLoading()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.service.createOrder(with: request) {  result in
                switch result {
                case .success(let flag):
                    if flag {
                        self?.view?.stopButtonLoading()
                        self?.showFinalDelivery()
                    } else {
                        self?.view?.stopButtonLoading()
                    }
                    
                case .failure: self?.view?.stopButtonLoading()
                }
            }
        }
    }
    
    func backButtonTapped() {
        showMeetingAppointment()
    }
    
    // MARK: Navigation
    
    private func showMeetingAppointment() {
        // TODO: coordinator?.move(MeetingAppointmentAssembly(), with: .pop)
    }
    
    private func showFinalDelivery() {
        // TODO: coordinator?.move(FinalDelivery(), with: .set)
    }
}
