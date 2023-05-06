//
//  OrderCheckoutPresenter.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 03.04.2023.
//

import UIKit

protocol OrderCheckoutPresenterProtocol {
    func getModuleType() -> OrderCheckoutModuleType
    func viewDidLoad()
    func backButtonTapped()
    func checkoutButtonTapped()
    func editButtonTapped()
    func yesButtonAlertTapped()
}

class OrderCheckoutPresenter: OrderCheckoutPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: IOrderCheckoutViewController?
    private let router: IOrderCheckoutRouter
    private let service: OrderCheckoutService
    private let mapper: IOrderCheckoutMapper
    
    // MARK: State
    
    private var item: OrderCheckout?
    private var type: OrderCheckoutModuleType
    
    // MARK: Init
    
    init(
        router: IOrderCheckoutRouter,
        service: OrderCheckoutService,
        mapper: IOrderCheckoutMapper,
        type: OrderCheckoutModuleType
    ) {
        self.router = router
        self.service = service
        self.mapper = mapper
        self.type = type
        self.item = OrderCheckout.init()
    }
    
    // MARK: OrderCheckoutPresenterProtocol
    
    func getModuleType() -> OrderCheckoutModuleType {
        type
    }
    
    func viewDidLoad() {
        guard let item else { return }
        view?.set(item: item)
    }
    
    func backButtonTapped() {
        // TODO: return back not only to MeetingAppointment
        showMeetingAppointment()
    }
    
    func checkoutButtonTapped() {
        switch type {
        case .creatingOrder: creatingType()
        case .editingOrder: editingType()
        }
    }
    
    func editButtonTapped() {
        // TODO: move to meeting appointment
    }
    
    func yesButtonAlertTapped() {
        service.deleteOrder()
        // TODO: show MyOrders with preview
    }
    
    // MARK: Private
    
    private func creatingType() {
        view?.startButtonLoading()
        
        //  TODO: добавить данные для создания запроса
        let request = mapper.toOrderCreateRequest()
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
    
    private func editingType() {
        view?.showAlert()
    }
    
    // MARK: Navigation
    
    private func showMeetingAppointment() {
        // TODO: coordinator?.move(MeetingAppointmentAssembly(), with: .pop)
    }
    
    private func showFinalDelivery() {
        guard let item else { return }
        router.openFinalDelivery(with: mapper.toFinalDelivery(from: item))
    }
}

// MARK: - IMeetingAppointmentModuleOutput, IMyOrdersModuleOutput

extension OrderCheckoutPresenter: IMeetingAppointmentModuleOutput {
    func meetingAppointment(didCompleteWith orderData: OrderCheckout) {
        self.item = orderData
    }
}

extension OrderCheckoutPresenter: IMyOrdersModuleOutput {
    func myOrders(didCompleteWith order: MyOrder) {
        self.item = mapper.toOrderCheckout(from: order)
    }
}
