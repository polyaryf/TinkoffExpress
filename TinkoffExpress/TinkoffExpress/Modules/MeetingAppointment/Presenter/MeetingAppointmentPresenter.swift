//
//  MeetingAppointmentPresenter.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit

protocol IMeetingAppointmentModuleOutput: AnyObject {
    /// тут подставила пока модельку следующего экрана
    /// но лучше передавать введенные данные, которые я потом на своем экране будут парсить
    func meetingAppointment(didCompleteWith orderData: OrderCheckout)
}

protocol MeetingAppointmentPresenterProtocol {
    func viewDidLoad()
    func addressButtonTapped()
    func didSelectItemAt(with collectionView: UICollectionView, and indexPath: IndexPath)
    func deliveryButtonTapped()
}

class MeetingAppointmentPresenter: MeetingAppointmentPresenterProtocol {
    // MARK: Dependencies

    weak var view: MeetingAppointmentViewController?
    private let router: IMeetingAppointmentRouter
    private let service: IMeetingAppointmentService

    // MARK: Init

    init(
        router: IMeetingAppointmentRouter,
        service: IMeetingAppointmentService
    ) {
        self.router = router
        self.service = service
    }
    
    // MARK: Life Cycle

    func viewDidLoad() {
        service.loadSlots(forDate: Date()) { result in
            print("DEBUG: \(result)")
        }
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
        // TODO: сделать смену открытия экрана
//        router.openAddressInput(output: self)
        router.openABtest(output: self)
    }
    
    private func showOrderCheckout() {
//        output?.meetingAppointment(didCompleteWith: OrderCheckout())
        router.openOrderCheckout(with: OrderCheckout())
    }
}

// MARK: - IAddressInputModuleOutput, IABTestModuleOutput

extension MeetingAppointmentPresenter: IAddressInputModuleOutput {
    func addressInputModule(didCompleteWith addressInput: String) {
        // TODO: Handle adressInput
    }
}

extension MeetingAppointmentPresenter: IABTestModuleOutput {
    func abTestModule(didCompleteWith addressInput: String) {
        print(addressInput)
        // TODO: Handle adressInput
    }
}
