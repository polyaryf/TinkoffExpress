//
//  MyOrdersPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import Foundation

protocol MyOrdersPresenterProtocol {
    func viewDidLoad()
    func didSelect(item: MyOrder)
}

final class MyOrdersPresenter: MyOrdersPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: IMyOrdersViewController?
    private let router: IMyOrdersRouter
    private let service: MyOrdersService
    private let formatter: ITEDateFormatter
    private let notifier: ITEOrdersNotifier
    
    // MARK: Init
    
    init(
        router: IMyOrdersRouter,
        service: MyOrdersService,
        formatter: ITEDateFormatter,
        notifier: ITEOrdersNotifier
    ) {
        self.router = router
        self.service = service
        self.formatter = formatter
        self.notifier = notifier
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        notifier.add(listener: self)
        loadItems()
    }
    
    func showNotification() {
      
        view?.showNotificationView()
    }
    
    // MARK: Events
    
    func didSelect(item: MyOrder) {
        router.openOrderCheckout(with: item.apiModel)
    }

    // MARK: Helpers

    private func loadItems() {
        service.loadItems { [weak self] items in
            guard let self = self else { return }

            let orders = items.map { apiOrder in
                MyOrder(
                    apiModel: apiOrder,
                    id: apiOrder.id,
                    text: "Доставка",
                    description: self.formatter.format(
                        date: apiOrder.deliverySlot.date,
                        timeFrom: apiOrder.deliverySlot.timeFrom,
                        timeTo: apiOrder.deliverySlot.timeTo
                    ),
                    imageName: "myOrdersDeliveryImage",
                    address: apiOrder.address.address,
                    paymentMethod: apiOrder.paymentMethod.localized
                )
            }
            self.view?.updateView(with: orders)
        }
    }
}

// MARK: - ITEOrdersNotificationsListener

extension MyOrdersPresenter: ITEOrdersNotificationsListener {
    func didCreateNewOrder() {
        loadItems()
    }

    func didUpdateOrder() {
        loadItems()
    }
    
    func didUpdateOrderWithDelete() {
        loadItems()
        view?.showNotificationView()
    }
}
