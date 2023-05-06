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
    func textViewDidChange(with textView: UITextView, _ countLabel: UILabel, _ deliveryButton: Button)
    func textViewDidBeginEditing(with textView: UITextView, _ countLabel: UILabel, _ clearButton: UIButton)
    func textViewDidEndEditing(with textView: UITextView, _ countLabel: UILabel, _ clearButton: UIButton)
    // swiftlint:disable:next function_parameter_count
    func keyboardWillShow(
        with notification: Notification,
        _ keyboardHeight: inout CGFloat,
        _ view: UIView,
        _ textView: UITextView,
        _ scrollView: UIScrollView,
        _ readyButton: UIButton
    )
    func keyboardWillHide(
        with notification: Notification,
        _ view: UIView,
        _ scrollView: UIScrollView,
        _ readyButton: UIButton
    )
    func clearButtonTapped(with textView: UITextView, _ countLabel: UILabel)
    func readyButtonTapped(with view: UIView)
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
        service.loadDates { [weak self] dates in
            guard let self else { return }
            self.view?.dates = dates ?? []
        }
        
        service.loadTimes { [weak self] times in
            guard let self else { return }
            self.view?.times = times ?? []
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
    
    func textViewDidChange(with textView: UITextView, _ countLabel: UILabel, _ deliveryButton: Button) {
        if textView.text.count > 150 {
            textView.deleteBackward()
        } else {
            countLabel.text = "Осталось \(150 - textView.text.count) символов"
        }
        
        let height = min(deliveryButton.frame.maxY - textView.frame.maxY, textView.sizeThatFits(CGSize(
            width: textView.frame.width,
            height: CGFloat.greatestFiniteMagnitude
        )).height)
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        if height >= deliveryButton.frame.maxY - textView.frame.maxY - 50 {
            textView.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(with textView: UITextView, _ countLabel: UILabel, _ clearButton: UIButton) {
        clearButton.isHidden = false
        view?.changeTextView(textView)
        countLabel.isHidden = false
        countLabel.text = "Осталось \(150 - textView.text.count) символов"
    }
    
    func textViewDidEndEditing(with textView: UITextView, _ countLabel: UILabel, _ clearButton: UIButton) {
        clearButton.isHidden = true
        
        if textView.text.count == 150 {
            countLabel.isHidden = true
        } else {
            countLabel.text = "Можно написать \(150 - textView.text.count) символов"
        }
        
        if textView.text.isEmpty {
            textView.text = "Как добраться и когда вам позвонить"
            textView.textColor = UIColor(named: "textViewPlaceholderColor")
        }
    }
    // swiftlint:disable:next function_parameter_count
    func keyboardWillShow(
        with notification: Notification,
        _ keyboardHeight: inout CGFloat,
        _ view: UIView,
        _ textView: UITextView,
        _ scrollView: UIScrollView,
        _ readyButton: UIButton
    ) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        keyboardHeight = keyboardFrame.size.height + readyButton.bounds.height + 32
        
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
        scrollView.scrollRectToVisible(textView.frame, animated: true)
        
        UIView.animate(withDuration: 0.5) {
            readyButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-(keyboardFrame.size.height + 16))
            }
            view.layoutSubviews()
        }
    }
    
    func keyboardWillHide(
        with notification: Notification,
        _ view: UIView,
        _ scrollView: UIScrollView,
        _ readyButton: UIButton
    ) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
        
        UIView.animate(withDuration: 0.5) {
            readyButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(60)
            }
            view.layoutSubviews()
        }
    }
    
    func clearButtonTapped(with textView: UITextView, _ countLabel: UILabel) {
        textView.text = ""
        countLabel.text = "Осталось 150 символов"
        textView.snp.updateConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    func readyButtonTapped(with view: UIView) {
        view.endEditing(true)
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
