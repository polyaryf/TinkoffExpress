//
//  OrderCheckoutPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol IOrderCheckoutModuleOutput: AnyObject {
    func orderCheckout(didCompleteWith orderData: OrderCheckout)
}

protocol OrderCheckoutPresenterProtocol {
    func viewDidLoad()
    func checkoutButtonTapped()
    func backButtonTapped()
}

class OrderCheckoutPresenter: OrderCheckoutPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: OrderCheckoutViewController?
    private let service: OrderCheckoutService
    
    // MARK: State
    
    private var item: OrderCheckout?
    
    // MARK: Init
    
    init(
        service: OrderCheckoutService
    ) {
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        guard let item else { return }
        view?.item = item
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

        service.createOrder(with: request) { [weak self] result in
            switch result {
            case .success(let flag):
                if flag {
                    self?.view?.stopButtonLoading()
                    self?.showFinalDelivery()
                } else {
                    self?.view?.stopButtonLoading()
                }

            case .failure:
                self?.view?.stopButtonLoading()
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
        // TODO: add output add move to FinalDelivery with set
//        output?.orderCheckout(didCompleteWith: item)
    }
}

extension OrderCheckoutPresenter: IMeetingAppointmentModuleOutput {
    func meetingAppointment(didCompleteWith orderData: OrderCheckout) {
        self.item = orderData
    }
}
