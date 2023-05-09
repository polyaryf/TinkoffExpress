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
        listener: ITEOrdersNotificationsListener
    ) {
        self.router = router
        self.service = service
        self.mapper = mapper
        self.type = type
        self.dateFormatter = dateFormatter
        self.listener = listener
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

    func viewDidSelect(paymentMethod: TEApiPaymentMethod) {
        selectedMethod = paymentMethod
        reloadView()
    }

    // MARK: Private
    
    private func creatingType() {
        view?.startButtonLoading()
        
        switch type {
        case .creatingOrder(let inputModel):
            let request = OrderCreateRequest(
                address: TEApiAddress(address: inputModel.address, lat: .zero, lon: .zero),
                paymentMethod: selectedMethod.rawValue,
                deliverySlot: inputModel.deliverySlot,
                items: [],
                comment: inputModel.comment,
                status: "NEW"
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
        case .editingOrder(let order):
            // TODO: Запрос на обновление существующего заказа
            break
        }
    }
    
    private func editingType() {
        view?.showCancelAlert(with: "Вы уверены, что хотите отменить доставку?")
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
    
    private func showMeetingAppointment() {}
    
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
}
