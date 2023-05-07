//
//  MeetingAppointmentViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit
import SnapKit

final class MeetingAppointmentViewController: UIViewController {
    // MARK: Dependencies
    
    private let presenter: MeetingAppointmentPresenterProtocol
    
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
        button.setTitle("Ивангород, ул. Гагарина, д. 1", for: .normal)
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
    
    private lazy var textView: UITextView = {
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
    
    private lazy var textPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Как добраться и когда вам позвонить"
        label.textColor = UIColor(named: "textViewPlaceholderColor")
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "clearButtonColor")
        button.isHidden = true
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var readyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "readyButtonColor")
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        return button
    }()
    
    private lazy var deliveryButton: Button = {
        let configuration = Button.Configuration(
            title: "Доставить сегодня",
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        let button = Button(configuration: configuration) { [ weak self ] in
            guard let self else { return }
            self.deliveryButtonTapped()
        }
        return button
    }()
    
    // MARK: State
    
    var dates: [MeetingAppointmentDate] = []
    var times: [MeetingAppointmentTime] = []
    
    // MARK: Init
    
    init(presenter: MeetingAppointmentPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "titleBackgroundColor")
        setupNavigationItem()
        setupViewsHierarchy()
        setupConstraints()
        setupKeyboardObservation()
        updateTextViewAccessories()
        presenter.viewDidLoad()
    }

    // MARK: Initial Configuration
    
    private func setupNavigationItem() {
        navigationItem.title = "Оформление доставки"
        navigationItem.backButtonTitle = ""
    }
    
    private func setupViewsHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(addressButton)
        scrollView.addSubview(dateCollectionView)
        scrollView.addSubview(timeCollectionView)
        scrollView.addSubview(textView)
        textView.addSubview(textPlaceholderLabel)
        view.addSubview(clearButton)
        scrollView.addSubview(countLabel)
        view.addSubview(readyButton)
        view.addSubview(deliveryButton)
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
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(timeCollectionView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        textPlaceholderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 47))
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(textView.snp.centerY)
            make.trailing.equalTo(textView.snp.trailing).offset(-12)
            make.size.equalTo(16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.equalTo(18)
        }
        
        readyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(60)
            make.width.equalTo(84)
            make.height.equalTo(44)
        }
        
        deliveryButton.snp.makeConstraints { make in
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
        presenter.addressButtonTapped()
    }
    
    private func deliveryButtonTapped() {
        presenter.deliveryButtonTapped()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInsets = keyboardFrame.size.height + readyButton.bounds.height + 32
        scrollView.contentInset.bottom = contentInsets
        scrollView.verticalScrollIndicatorInsets.bottom = contentInsets
        scrollView.scrollRectToVisible(textView.frame, animated: true)
        
        UIView.animate(withDuration: 0.5) { [self] in
            readyButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-(keyboardFrame.size.height + 16))
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
        
        UIView.animate(withDuration: 0.5) { [self] in
            readyButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(60)
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc private func clearButtonTapped() {
        textView.text = ""
        textView.snp.updateConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Helpers

    private func updateTextViewAccessories() {
        if textView.isFirstResponder || textView.hasText {
            countLabel.text = "Осталось \(.maxTextViewContentLength - textView.text.count) символов"
        } else {
            countLabel.text = "Можно написать \(Int.maxTextViewContentLength) символов"
        }
        
        textPlaceholderLabel.isHidden = textView.isFirstResponder || textView.hasText

        clearButton.isHidden = textView.isFirstResponder
    }
}

// MARK: - UICollectionViewDataSource

extension MeetingAppointmentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case dateCollectionView:
            return dates.count
        default:
            return times.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case dateCollectionView:
            let cell = collectionView.dequeue(DateCell.self, for: indexPath)
            cell.setupCell(text: dates[indexPath.row].date)
            return cell
        default:
            let cell = collectionView.dequeue(TimeCell.self, for: indexPath)
            cell.setupCell(timeText: times[indexPath.row].time, dateText: times[indexPath.row].date)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MeetingAppointmentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(with: collectionView, and: indexPath)
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
        
        updateTextViewAccessories()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateTextViewAccessories()
    }
}

// MARK: - Constants

private extension Int {
    static let maxTextViewContentLength = 150
}
