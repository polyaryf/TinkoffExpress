//
//  MeetingAppointmentPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit

protocol MeetingAppointmentPresenterProtocol {
    func viewDidLoad()
    func addressButtonTapped()
    func didSelectItemAt(with collectionView: UICollectionView, and indexPath: IndexPath)
    func deliveryButtonTapped()
}

class MeetingAppointmentPresenter: MeetingAppointmentPresenterProtocol {
    // MARK: Dependencies

    weak var view: MeetingAppointmentViewController?
    private var coordinator: Coordinator?
    private var service: MeetingAppointmentService?

    // MARK: Init
    init(coordinator: Coordinator, service: MeetingAppointmentService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    // MARK: Life Cycle
    
    func viewDidLoad() {
        service?.loadDates(completion: { [ weak self ] dates in
            guard let self else { return }
            self.view?.dates = dates ?? []
        })
        
        service?.loadTimes(completion: { [ weak self ] times in
            guard let self else { return }
            self.view?.times = times ?? []
        })
    }
    
    // MARK: Events
    
    func addressButtonTapped() {
        showSearch()
    }
    
    func didSelectItemAt(with collectionView: UICollectionView, and indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
            let firstSelectedIndexPath = selectedIndexPaths.first,
            let firstSelectedCell = collectionView.cellForItem(at: firstSelectedIndexPath) {
                firstSelectedCell.isSelected = false
                selectedIndexPaths.forEach { collectionView.deselectItem(at: $0, animated: true) }
            }
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    func deliveryButtonTapped() {
        showOrderCheckout()
    }
    
    // MARK: Navigation
    
    private func showSearch() {
        // TODO: coordinator?.moveToSearch()
    }
    
    private func showOrderCheckout() {
        // TODO: coordinator?.moveToOrderCheckout
    }
}
