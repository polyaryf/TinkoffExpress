//
//  MeetingAppointmentViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 26.03.2023.
//

import UIKit
import SnapKit
// swiftlint:disable:next line_length
final class MeetingAppointmentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    // MARK: Dependencies
    
    private var meetingAppointmentPresenter: MeetingAppointmentPresenterProtocol?
    
    // MARK: Properties

    private var keyboardHeight: CGFloat = 0
    var dates: [MeetingAppointmentDate] = []
    var times: [MeetingAppointmentTime] = []
    
    // MARK: Subviews
    
    private lazy var scrollView = UIScrollView()
    private lazy var addressButton = UIButton()
    private lazy var dateCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private lazy var timeCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private lazy var textView = UITextView()
    private lazy var clearButton = UIButton(type: .system)
    private lazy var countLabel = UILabel()
    private lazy var readyButton = UIButton()
    private lazy var deliveryButton: Button = {
        let config = Button.Configuration(
            title: "Доставить сегодня",
            style: .primaryTinkoff,
            contentSize: .basicLarge
        )
        let button = Button(configuration: config) { [ weak self ] in
            guard let self else { return }
            self.deliveryButtonTapped()
        }
        return button
    }()
    
    init(meetingAppointmentPresenter: MeetingAppointmentPresenterProtocol) {
        self.meetingAppointmentPresenter = meetingAppointmentPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meetingAppointmentPresenter?.viewDidLoad()
        
        setupScrollView()
        setupAddressButton()
        setupDateCollectionView()
        setupTimeCollectionView()
        setupTextView()
        setupClearButton()
        setupCountLabel()
        setupReadyButton()
        setupDeliveryButton()
        setupColors()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Оформление доставки"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dateCollectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .centeredHorizontally
        )
        timeCollectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .centeredHorizontally
        )
    }
    
    // MARK: Actions
    
    @objc private func addressButtonTapped() {
        meetingAppointmentPresenter?.addressButtonTapped()
    }
    
    private func deliveryButtonTapped() {
        meetingAppointmentPresenter?.deliveryButtonTapped()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        meetingAppointmentPresenter?.didSelectItemAt(with: collectionView, and: indexPath)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        meetingAppointmentPresenter?.textViewDidChange(with: textView, countLabel, deliveryButton)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        meetingAppointmentPresenter?.textViewDidBeginEditing(with: textView, countLabel, clearButton)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        meetingAppointmentPresenter?.textViewDidEndEditing(with: textView, countLabel, clearButton)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        meetingAppointmentPresenter?.keyboardWillShow(
            with: notification,
            &keyboardHeight,
            view,
            textView,
            scrollView,
            readyButton
        )
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        meetingAppointmentPresenter?.keyboardWillHide(with: notification, view, scrollView, readyButton)
    }
    
    @objc private func clearButtonTapped() {
        meetingAppointmentPresenter?.clearButtonTapped(with: textView, countLabel)
    }
    
    @objc private func readyButtonTapped() {
        meetingAppointmentPresenter?.readyButtonTapped(with: view)
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "titleBackgroundColor")
        scrollView.backgroundColor = UIColor(named: "meetingAppointmentBackgroundColor")
        addressButton.setTitleColor(UIColor(named: "textColor"), for: .normal)
        addressButton.backgroundColor = UIColor(named: "addressButtonColor")
        dateCollectionView.backgroundColor = .clear
        timeCollectionView.backgroundColor = .clear
        textView.backgroundColor = UIColor(named: "textViewButtonColor")
        textView.textColor = UIColor(named: "textViewPlaceholderColor")
        clearButton.tintColor = UIColor(named: "clearButtonColor")
        readyButton.backgroundColor = UIColor(named: "readyButtonColor")
        countLabel.textColor = UIColor(named: "textColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupScrollView() {
        scrollView.layer.cornerRadius = 20
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func setupAddressButton() {
        addressButton.setTitle("Ивангород, ул. Гагарина, д. 1", for: .normal)
        addressButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        addressButton.contentHorizontalAlignment = .leading
        addressButton.contentVerticalAlignment = .center
        addressButton.titleEdgeInsets.left = 12
        addressButton.titleEdgeInsets.right = 12
        addressButton.layer.cornerRadius = 16
        addressButton.addTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(addressButton)
        
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(24)
            make.leading.equalTo(scrollView.snp.leading).offset(16)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-16)
            make.width.equalTo(view.bounds.size.width - 32)
            make.height.equalTo(56)
        }
    }
    
    private func setupDateCollectionView() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        let dateLayout = UICollectionViewFlowLayout()
        dateLayout.scrollDirection = .horizontal
        dateCollectionView.setCollectionViewLayout(dateLayout, animated: false)
        dateCollectionView.showsHorizontalScrollIndicator = false
        dateCollectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        
        scrollView.addSubview(dateCollectionView)
        
        dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addressButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    private func setupTimeCollectionView() {
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        let timeLayout = UICollectionViewFlowLayout()
        timeLayout.scrollDirection = .horizontal
        timeCollectionView.setCollectionViewLayout(timeLayout, animated: false)
        timeCollectionView.showsHorizontalScrollIndicator = false
        timeCollectionView.register(TimeCell.self, forCellWithReuseIdentifier: "TimeCell")
        
        scrollView.addSubview(timeCollectionView)
        
        timeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(82)
        }
    }
    
    private func setupTextView() {
        textView.delegate = self
        textView.text = "Как добраться и когда вам позвонить"
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.showsVerticalScrollIndicator = false
        textView.textContainerInset = .init(top: 18, left: 12, bottom: 18, right: 47)
        textView.layer.cornerRadius = 16
        textView.isScrollEnabled = false
    
        scrollView.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(timeCollectionView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    private func setupClearButton() {
        clearButton.isHidden = true
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        view.addSubview(clearButton)
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(textView.snp.centerY)
            make.trailing.equalTo(textView.snp.trailing).offset(-12)
            make.size.equalTo(16)
        }
    }
    
    private func setupCountLabel() {
        countLabel.text = "Можно написать 150 символов"
        countLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        scrollView.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(28)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.equalTo(18)
        }
    }
    
    private func setupReadyButton() {
        readyButton.setTitle("Готово", for: .normal)
        readyButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        readyButton.layer.cornerRadius = 12
        readyButton.layer.shadowColor = UIColor.black.cgColor
        readyButton.layer.shadowOpacity = 0.1
        readyButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        readyButton.layer.shadowRadius = 4
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        
        view.addSubview(readyButton)
            
        readyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(60)
            make.width.equalTo(84)
            make.height.equalTo(44)
        }
    }
    
    private func setupDeliveryButton() {
        view.addSubview(deliveryButton)
        
        deliveryButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollectionView {
            return dates.count
        } else {
            return times.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            if let dateCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "DateCell",
                for: indexPath
            ) as? DateCell {
                let textDateCell = dates[indexPath.row].date
                dateCell.setupCell(text: textDateCell)
                return dateCell
            }
        } else {
            if let timeCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "TimeCell",
                for: indexPath
            ) as? TimeCell {
                let textTimeCell = times[indexPath.row].time
                let textDateCell = times[indexPath.row].date
                timeCell.setupCell(timeText: textTimeCell, dateText: textDateCell)
                return timeCell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == dateCollectionView {
            return CGSize(width: 77, height: 30)
        } else {
            return CGSize(width: 116, height: 62)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        if collectionView == dateCollectionView {
            return 8
        } else {
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
