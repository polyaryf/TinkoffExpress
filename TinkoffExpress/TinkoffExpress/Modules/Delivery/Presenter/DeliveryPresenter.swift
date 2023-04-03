//
//  DeliveryPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import Foundation

protocol DeliveryPresenterProtocol {
    func viewDidLoad()
    func didSelectItemAt()
}

final class DeliveryPresenter: DeliveryPresenterProtocol {
    // MARK: Dependencies
    
    weak var view: DeliveryViewController?
    private var coordinator: Coordinator?
    private var service: DeliveryService?
    
    // MARK: Init
    init(coordinator: Coordinator, service: DeliveryService) {
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
    
    func didSelectItemAt() {
        showOnboarding()
    }
    
    // MARK: Navigation
    
    private func showOnboarding() {
        // TODO: coordinator?.move(OnboardingAssembly(), with: .push)
    }
}
