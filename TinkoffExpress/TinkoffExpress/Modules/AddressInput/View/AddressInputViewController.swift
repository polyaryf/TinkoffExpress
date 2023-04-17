//
//  AddressInputViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 14.04.2023.
//

import UIKit

protocol AddressInputViewControllerProtocol: UIViewController {
    func showAddresses(addresses: [InputAddress])
    func showErrorLabel()
}

class AddressInputViewController: UIViewController {
    // MARK: Subviews
    
    private lazy var cancelButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.tintColor = UIColor(named: "blue.addressInput.color")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var inputTextView: TextView = {
        var textView = TextView.init()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    private lazy var clearInputTextButton: UIButton = {
        var button = UIButton.init()
        button.setImage(UIImage(named: "x.cross.addressInput"), for: .normal)
        button.addTarget(self, action: #selector(clearInputTextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var tableView: UITableView = {
        var table = UITableView.init()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var doneButton: UIButton = {
        var button = UIButton.init()
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var errorLabel: UILabel = {
        var label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Dependencies
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupTableView()
        setupInputTextView()
        setupErrorLable()
        setupDoneButtonView()
        setupKeyboard()
        
        trackTextViewChanges()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(cancelButton)
        view.addSubview(inputTextView)
        view.addSubview(tableView)
        view.addSubview(doneButton)
        view.addSubview(errorLabel)
        inputTextView.addSubview(clearInputTextButton)
    }
    
    private func setupConstraints() {
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16)
        }
        inputTextView.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        clearInputTextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(331)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(16)
            $0.width.equalTo(16)
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
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AddressInputCell.self, forCellReuseIdentifier: "addressInputCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupInputTextView() {
        inputTextView.showsVerticalScrollIndicator = false
        inputTextView.backgroundColor = UIColor(named: "inputTextView.addressInput.color")
        inputTextView.textColor = UIColor(named: "inputText.addressInput.color")
        inputTextView.textContainerInset = UIEdgeInsets(
            top: 18,
            left: 14,
            bottom: 18,
            right: 28
        )
        inputTextView.layer.cornerRadius = 16
        inputTextView.clipsToBounds = true
        inputTextView.font = .systemFont(ofSize: 17)
    }
    
    private func setupErrorLable() {
        errorLabel.isHidden = true
        errorLabel.text = "Мы не знаем этого адреса"
        errorLabel.textColor = UIColor(named: "errorText.addressInput.color")
        errorLabel.font = .systemFont(ofSize: 15)
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
        doneButton.titleLabel?.font = .systemFont(ofSize: 15)
        doneButton.backgroundColor = UIColor(named: "blue.addressInput.color")
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
        address = []
        tableView.reloadData()
    }
    
    // MARK: Keyboard
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.size.height
        
        UIView.animate(withDuration: 0.5) { [self] in
            doneButton.snp.remakeConstraints {
                $0.bottom.equalToSuperview().offset(-(keyboardHeight + 16))
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutSubviews()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.5) { [self] in
            doneButton.snp.remakeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutSubviews()
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
        cell.setPrimaryText(currentAddress.street)
        cell.setSecondaryText(currentAddress.wholeAddress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}

// MARK: - AddressInputViewControllerProtocol

extension AddressInputViewController: AddressInputViewControllerProtocol {
    func showAddresses(addresses: [InputAddress]) {
        self.address += addresses
        tableView.reloadData()
    }
    
    func showErrorLabel() {
        errorLabel.isHidden = false
    }
}

// MARK: - Handling TextView

extension AddressInputViewController {
    func trackTextViewChanges() {
        inputTextView.textDidChangeHandler = { [self] in
            guard let inputText = inputTextView.text else { return }
            presenter.viewDidLoad(input: inputText)
        }
        
        inputTextView.viewSizeDidChangeHandler = { [self] in
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
            clearInputTextButton.snp.updateConstraints {
                $0.top.equalToSuperview().offset(paddingClearInputTextButton)
                $0.bottom.equalToSuperview().offset(-paddingClearInputTextButton)
            }
        }
    }
}
