//
//  AddressInputViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 14.04.2023.
//

import UIKit

protocol AddressInputViewControllerProtocol: AnyObject {
    func showAddresses(addresses: [InputAddress])
    func showErrorLabel()
    func closeView()
}

class AddressInputViewController: UIViewController {
    // MARK: Subviews

    private lazy var inputTextView: TextView = {
        var textView = TextView.init()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var tableView: UITableView = {
        var table = UITableView.init()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var doneButton: UIButton = {
        var button = UIButton.init()
        button.setTitle(NSLocalizedString("addressInputReadyButton", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    private lazy var errorLabel: UILabel = {
        var label = UILabel.init()
        label.isHidden = true
        label.text = NSLocalizedString("addressInputErrorLabelText", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Dependency
    
    private var presenter: AddressInputPresenterProtocol
    
    // MARK: Init
        
    init(presenter: AddressInputPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Property
    
    var address: [InputAddress] = []
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        setupNavigationItem()
        setupViewHierarchy()
        setupConstraints()
        setupColors()
        setupFonts()
        setupTableView()
        setupInputTextView()
        setupDoneButtonView()
        setupKeyboard()
        
        trackTextViewChanges()
    }

    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("addressInputCancelButton", comment: ""),
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
    }
    
    private func setupViewHierarchy() {
        view.addSubview(inputTextView)
        view.addSubview(tableView)
        view.addSubview(doneButton)
        view.addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        inputTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(inputTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
            $0.width.equalTo(84)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(28)
        }
    }
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "background.addressInput.color")
        tableView.backgroundColor = UIColor(named: "background.addressInput.color")
        inputTextView.tintColor = UIColor(named: "blue.addressInput.color")
        inputTextView.backgroundColor = UIColor(named: "inputTextView.addressInput.color")
        inputTextView.textColor = UIColor(named: "inputText.addressInput.color")
        errorLabel.textColor = UIColor(named: "errorText.addressInput.color")
        doneButton.backgroundColor = UIColor(named: "blue.addressInput.color")
    }
    
    private func setupFonts() {
        inputTextView.font = .systemFont(ofSize: 17)
        errorLabel.font = .systemFont(ofSize: 15)
        doneButton.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AddressInputCell.self, forCellReuseIdentifier: "addressInputCell")
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupInputTextView() {
        inputTextView.setClearButton(superViewSize: view.frame)
        guard let clearButton = inputTextView.viewWithTag(111) as? UIButton else { return }
        clearButton.addTarget(self, action: #selector(clearInputTextButtonTapped), for: .touchUpInside)
       
        inputTextView.setPlaceholder(with: NSLocalizedString("addressInputPlaceholder", comment: ""))
        inputTextView.showsVerticalScrollIndicator = false
        inputTextView.layer.cornerRadius = 16
        inputTextView.clipsToBounds = true
        inputTextView.textContainerInset = UIEdgeInsets(
            top: 18,
            left: 14,
            bottom: 18,
            right: 28
        )
    }
    
    private func setupDoneButtonView() {
        doneButton.layer.cornerRadius = 12
        doneButton.clipsToBounds = true
        doneButton.titleEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 18,
            bottom: 13,
            right: 18
        )
    }
    
    private func setupKeyboard() {
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
    
    // MARK: Action
    
    @objc func clearInputTextButtonTapped() {
        inputTextView.text = ""
        textViewSizeDidChange()
        
        errorLabel.isHidden = true
        
        address = []
        tableView.reloadData()
    }
    
    @objc func doneButtonTapped() {
        presenter.doneButtonTapped()
    }
    
    @objc func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    // MARK: Keyboard
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        let keyboardHeight = keyboardFrame.size.height
         
        UIView.animate(withDuration: duration ) { [self] in
            doneButton.snp.remakeConstraints {
                $0.bottom.equalToSuperview().offset(-(keyboardHeight + 16))
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutIfNeeded()
            doneButton.isHidden = false
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        UIView.animate(withDuration: duration ) { [self] in
            doneButton.isHidden = true
            doneButton.snp.remakeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension AddressInputViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressInputCell()
        let currentAddress = address[indexPath.row]
        cell.setPrimaryText(currentAddress.firstLine)
        cell.setSecondaryText(currentAddress.wholeAddress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = address[indexPath.row].wholeAddress
        inputTextView.text = text
        textViewSizeDidChange()
        presenter.viewDidChangeText(input: text)
    }
}

// MARK: - AddressInputViewControllerProtocol

extension AddressInputViewController: AddressInputViewControllerProtocol {
    func showAddresses(addresses: [InputAddress]) {
        errorLabel.isHidden = true
        
        self.address = addresses
        tableView.reloadData()
    }
    
    func showErrorLabel() {
        errorLabel.isHidden = false
        
        address = []
        tableView.reloadData()
    }

    func closeView() {
        dismiss(animated: true)
    }
}

// MARK: - Handling TextView

extension AddressInputViewController {
    private func trackTextViewChanges() {
        inputTextView.textDidChangeHandler = { [weak self] in
            guard let self = self else { return }
            guard let inputText = self.inputTextView.text else { return }
            self.presenter.viewDidChangeText(input: inputText)
        }
        
        inputTextView.viewSizeDidChangeHandler = { [weak self] in
            self?.textViewSizeDidChange()
        }
    }
    
    private func textViewSizeDidChange() {
        inputTextView.checkPlaceholder()
        let height = inputTextView.sizeThatFits(
            CGSize(
                width: inputTextView.frame.width - 0.5,
                height: CGFloat.leastNonzeroMagnitude
            )
        ).height

        inputTextView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        
        let paddingClearInputTextButton = (height - 16) / 2
        guard let clearButton = inputTextView.viewWithTag(111) else { return }
        clearButton.snp.updateConstraints {
            $0.top.equalToSuperview().offset(paddingClearInputTextButton)
            $0.bottom.equalToSuperview().offset(-paddingClearInputTextButton)
        }
    }
}
