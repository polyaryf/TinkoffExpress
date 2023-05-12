//
//  MeetingAppointmentViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit
import SnapKit

// swiftlint:disable file_length

protocol IMeetingAppointmentView: AnyObject {
    func reloadDateCollection()
    func selectDateSlot(at index: Int)
    func selectTimeSlot(at index: Int)
    func reloadTimeCollection(animated: Bool)
    func set(address: String)
    func set(primaryButtonTitle: String)
    func setPrimaryButtonsTinkoffStyle()
    func setPrimaryButtonsDestructiveStyle()
    func showErrorAlert()
    func closeView()
}

final class MeetingAppointmentViewController: UIViewController {
    // MARK: Dependencies
    
    private let presenter: IMeetingAppointmentPresenter
    
    // MARK: Subviews
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 20
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(named: "meetingAppointmentBackgroundColor")
        return scrollView
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.backgroundColor = UIColor(named: "addressButtonColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        button.titleEdgeInsets.left = 12
        button.titleEdgeInsets.right = 12
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DateCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var timeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TimeCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(named: "textViewButtonColor")
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.showsVerticalScrollIndicator = false
        textView.textContainerInset = .init(top: 18, left: 12, bottom: 18, right: 47)
        textView.layer.cornerRadius = 16
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var commentPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("meetingAppointmentCommentPlaceholder", comment: "")
        label.textColor = UIColor(named: "textViewPlaceholderColor")
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var clearCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "clearButtonColor")
        button.isHidden = true
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var hideKeyboardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "readyButtonColor")
        button.setTitle(NSLocalizedString("meetingAppointmentReadyButton", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        return button
    }()
    
    private lazy var primaryButton: Button = {
        let configuration = Button.Configuration(
            title: "",
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        let button = Button(configuration: configuration) { [ weak self ] in
            guard let self else { return }
            self.deliveryButtonTapped()
        }
        return button
    }()
    
    private var commentInfoPressed1 = NSLocalizedString("meetingAppointmentCommentInfoPressed1", comment: "")
    private var commentInfoPressed2 = NSLocalizedString("meetingAppointmentCommentInfoPressed2", comment: "")
    private var commentInfoNotPressed1 = NSLocalizedString("meetingAppointmentCommentInfoNotPressed1", comment: "")
    private var commentInfoNotPressed2 = NSLocalizedString("meetingAppointmentCommentInfoNotPressed2", comment: "")
    
    // MARK: Init
    
    init(presenter: IMeetingAppointmentPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationItem()
        setupViewsHierarchy()
        setupConstraints()
        setupKeyboardObservation()
        updateTextViewAccessories()
        presenter.viewDidLoad()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "titleBackgroundColor")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = NSLocalizedString("meetingAppointmentTitle", comment: "")
        navigationItem.backButtonTitle = ""
    }
    
    private func setupViewsHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(addressButton)
        scrollView.addSubview(dateCollectionView)
        scrollView.addSubview(timeCollectionView)
        scrollView.addSubview(commentTextView)
        commentTextView.addSubview(commentPlaceholderLabel)
        view.addSubview(clearCommentButton)
        scrollView.addSubview(commentCountLabel)
        view.addSubview(hideKeyboardButton)
        view.addSubview(primaryButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(24)
            make.leading.equalTo(scrollView.snp.leading).offset(16)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-16)
            make.width.equalTo(view.bounds.size.width - 32)
            make.height.equalTo(56)
        }
        
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addressButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        timeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(82)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(timeCollectionView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        commentPlaceholderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 47))
        }
        
        clearCommentButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextView.snp.centerY)
            make.trailing.equalTo(commentTextView.snp.trailing).offset(-12)
            make.size.equalTo(16)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.top.equalTo(commentTextView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.equalTo(18)
        }
        
        hideKeyboardButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(60)
            make.width.equalTo(84)
            make.height.equalTo(44)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
    }
        
    private func setupKeyboardObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: Events
    
    @objc private func addressButtonTapped() {
        presenter.viewDidTapAddress()
    }
    
    private func deliveryButtonTapped() {
        presenter.viewDidTapPrimaryButton()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInsets = keyboardFrame.size.height + hideKeyboardButton.bounds.height + 32
        scrollView.contentInset.bottom = contentInsets
        scrollView.verticalScrollIndicatorInsets.bottom = contentInsets
        scrollView.scrollRectToVisible(commentTextView.frame, animated: true)
        
        UIView.animate(withDuration: 0.5) { [self] in
            hideKeyboardButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-(keyboardFrame.size.height + 16))
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
        
        UIView.animate(withDuration: 0.5) { [self] in
            hideKeyboardButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(60)
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc private func clearButtonTapped() {
        commentTextView.text = ""
        commentTextView.snp.updateConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Helpers

    private func updateTextViewAccessories() {
        if commentTextView.isFirstResponder || commentTextView.hasText {
            commentCountLabel.text =
            "\(commentInfoPressed1) \(.maxTextViewContentLength - commentTextView.text.count) \(commentInfoPressed2)"
        } else {
            commentCountLabel.text =
            "\(commentInfoNotPressed1) \(Int.maxTextViewContentLength) \(commentInfoNotPressed2)"
        }
        
        commentPlaceholderLabel.isHidden = commentTextView.isFirstResponder || commentTextView.hasText
        clearCommentButton.isHidden = !commentTextView.isFirstResponder
    }
}

// MARK: - IMeetingAppointmentView

extension MeetingAppointmentViewController: IMeetingAppointmentView {
    func reloadDateCollection() {
        dateCollectionView.reloadData()
    }
    
    func selectDateSlot(at index: Int) {
        dateCollectionView.selectItem(
            at: IndexPath(item: index, section: .zero),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }
    
    func selectTimeSlot(at index: Int) {
        timeCollectionView.selectItem(
            at: IndexPath(item: index, section: .zero),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }
    
    func reloadTimeCollection(animated: Bool) {
        animated
            ? timeCollectionView.reloadSections(IndexSet(integer: .zero))
            : timeCollectionView.reloadData()
    }
    
    func set(address: String) {
        addressButton.setTitle(address, for: .normal)
    }
    
    func set(primaryButtonTitle: String) {
        primaryButton.setTitle(primaryButtonTitle)
    }
    
    func setPrimaryButtonsTinkoffStyle() {
        primaryButton.setStyle(.primaryTinkoff)
    }
    
    func setPrimaryButtonsDestructiveStyle() {
        primaryButton.setStyle(.destructive)
    }
    
    func showErrorAlert() {
        present(UIAlertController.defaultErrorAlert(), animated: true)
    }
    
    func closeView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MeetingAppointmentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case dateCollectionView:
            return presenter.viewDidRequestNumberOfDateSlots()
        default:
            return presenter.viewDidRequestNumberOfTimeSlots()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case dateCollectionView:
            let model = presenter.viewDidRequestDateSlot(at: indexPath.row)
            let cell = collectionView.dequeue(DateCell.self, for: indexPath)
            cell.setupCell(text: model.date)
            return cell
        default:
            let model = presenter.viewDidRequestTimeSlot(at: indexPath.row)
            let cell = collectionView.dequeue(TimeCell.self, for: indexPath)
            cell.setupCell(timeText: model.time, dateText: model.date)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MeetingAppointmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        switch collectionView {
        case dateCollectionView:
            presenter.viewDidSelectDateSlot(at: indexPath.row)
        default:
            presenter.viewDidSelectTimeSlot(at: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch collectionView {
        case dateCollectionView:
            return true
        default:
            return presenter.viewShouldSelectTimeSlot(at: indexPath.row)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MeetingAppointmentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView {
        case dateCollectionView:
            return CGSize(width: 77, height: 30)
        default:
            return CGSize(width: 116, height: 62)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        switch collectionView {
        case dateCollectionView:
            return 8
        default:
            return 12
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UITextViewDelegate

extension MeetingAppointmentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateTextViewAccessories()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > .maxTextViewContentLength {
            textView.deleteBackward()
        }
        
        let height = min(primaryButton.frame.maxY - textView.frame.maxY, textView.sizeThatFits(CGSize(
            width: textView.frame.width,
            height: CGFloat.greatestFiniteMagnitude
        )).height)
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        if height >= primaryButton.frame.maxY - textView.frame.maxY - 50 {
            textView.deleteBackward()
        }
        
        updateTextViewAccessories()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateTextViewAccessories()
        presenter.viewDidChange(comment: textView.text)
    }
}

// MARK: - Constants

private extension Int {
    static let maxTextViewContentLength = 150
}
