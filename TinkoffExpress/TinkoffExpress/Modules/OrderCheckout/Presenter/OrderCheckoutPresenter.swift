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
    func viewDidSelect(paymentMethod: TEApiPaymentMethod)
}

class OrderCheckoutPresenter: OrderCheckoutPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: IOrderCheckoutViewController?
    private let router: IOrderCheckoutRouter
    private let service: OrderCheckoutService
    private let mapper: IOrderCheckoutMapper
    private let dateFormatter: ITEDateFormatter
    private let listener: ITEOrdersNotificationsListener
    private let cartService: ICartService
    
    // MARK: State
    
    private var type: OrderCheckoutModuleType
    private var selectedMethod: TEApiPaymentMethod = .card
    
    // MARK: Init
    
    init(
        router: IOrderCheckoutRouter,
        service: OrderCheckoutService,
        mapper: IOrderCheckoutMapper,
        type: OrderCheckoutModuleType,
        dateFormatter: ITEDateFormatter,
        listener: ITEOrdersNotificationsListener,
        cartService: ICartService
    ) {
        self.router = router
        self.service = service
        self.mapper = mapper
        self.type = type
        self.dateFormatter = dateFormatter
        self.listener = listener
        self.cartService = cartService
    }
    
    // MARK: OrderCheckoutPresenterProtocol
    
    func getModuleType() -> OrderCheckoutModuleType {
        type
    }
    
    func viewDidLoad() {
        switch type {
        case let .editingOrder(apiOrder):
            selectedMethod = apiOrder.paymentMethod
        case .creatingOrder:
            break
        }
        
        reloadView()
    }
    
    func backButtonTapped() {
        switch type {
        case .editingOrder:
            showMyOrders()
        case .creatingOrder:
            showMeetingAppointment()
        }
    }
    
    func checkoutButtonTapped() {
        switch type {
        case .creatingOrder: creatingType()
        case .editingOrder: editingType()
        }
    }
    
    func editButtonTapped() {
        showMeetingAppointment()
    }
    
    func yesButtonAlertTapped() {
        switch type {
        case let .editingOrder(apiOrder):
            service.delete(order: apiOrder) { [weak self] result in
                switch result {
                case .success(let flag):
                    if flag {
                        self?.listener.didUpdateOrderWithDelete()
                        self?.showMyOrders()
                    }
                case .failure: break
                }
            }
        case .creatingOrder:
            break
        }
    }
    
    func viewDidSelect(paymentMethod: TEApiPaymentMethod) {
        selectedMethod = paymentMethod
        reloadView()
        
        switch type {
        case .creatingOrder:
            break
        case .editingOrder(let order):
            serviceUpdateRequest(with: order)
        }
    }
    
    // MARK: Private
    
    private func creatingType() {
        view?.startButtonLoading()
        
        switch type {
        case .creatingOrder(let inputModel):
            serviceCreateRequest(with: inputModel)
        case .editingOrder(let order):
            serviceUpdateRequest(with: order)
        }
    }
    
    private func editingType() {
        view?.showCancelAlert(with: "Вы уверены, что хотите отменить доставку?")
    }
    
    private func serviceCreateRequest(with inputModel: NewOrderInputModel) {
        let request = OrderCreateRequest(
            address: TEApiAddress(address: inputModel.address, lat: .zero, lon: .zero),
            paymentMethod: selectedMethod.rawValue,
            deliverySlot: inputModel.deliverySlot,
            items: mapper.toTEApiItems(from: cartService.getAll()),
            comment: inputModel.comment,
            status: .created
        )
        
        service.createOrder(with: request) { [weak self] result in
            switch result {
            case .success(let flag):
                if flag {
                    self?.listener.didCreateNewOrder()
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
    
    private func serviceUpdateRequest(with order: TEApiOrder) {
        let request = OrderUpdateRequest(
            address: order.address,
            paymentMethod: selectedMethod.rawValue,
            deliverySlot: order.deliverySlot,
            comment: order.comment,
            status: .created
        )
        service.updateOrder(
            id: order.id,
            with: request
        ) { [weak self] result in
            switch result {
            case .success(let flag):
                if flag {
                    self?.listener.didUpdateOrder()
                    self?.view?.stopButtonLoading()
                }
            case .failure:
                self?.view?.stopButtonLoading()
            }
        }
    }

    private func reloadView() {
        let item: OrderCheckout

        switch type {
        case let .editingOrder(apiOrder):
            item = OrderCheckout(
                whatWillBeDelivered: "Посылку",
                deliveryWhen: dateFormatter.format(
                    date: apiOrder.deliverySlot.date,
                    timeFrom: apiOrder.deliverySlot.timeFrom,
                    timeTo: apiOrder.deliverySlot.timeTo
                ),
                deliveryWhere: apiOrder.address.address,
                paymentMethod: selectedMethod.localized
            )
        case let .creatingOrder(inputModel):
            item = OrderCheckout(
                whatWillBeDelivered: "Посылку",
                deliveryWhen: dateFormatter.format(
                    date: inputModel.deliverySlot.date,
                    timeFrom: inputModel.deliverySlot.timeFrom,
                    timeTo: inputModel.deliverySlot.timeTo
                ),
                deliveryWhere: inputModel.address,
                paymentMethod: selectedMethod.localized
            )
        }

        view?.set(item: item)
    }
    
    // MARK: Navigation
    
    private func showMeetingAppointment() {
        switch type {
        case .creatingOrder:
            view?.closeView()
        case .editingOrder(let order):
            router.openMeetingAppointment(with: order)
        }
    }
    
    private func showFinalDelivery() {
        switch type {
        case let .creatingOrder(model):
            let finalDelivery = FinalDelivery(
                where: model.address,
                when: dateFormatter.format(
                    date: model.deliverySlot.date,
                    timeFrom: model.deliverySlot.timeFrom,
                    timeTo: model.deliverySlot.timeTo
                ),
                what: "Посылку"
            )
            router.openFinalDelivery(with: finalDelivery)
        case .editingOrder:
            break
        }
    }
    
    private func showMyOrders() {
        view?.closeView()
    }
}
