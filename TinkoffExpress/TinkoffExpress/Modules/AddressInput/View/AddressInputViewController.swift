//
//  AddressInputViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 14.04.2023.
//

import UIKit

class AddressInputViewController: UIViewController {
    // MARK: Subviews
    
    private lazy var cancelButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var inputTextView: UITextView = {
        var textView = UITextView.init()
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
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        setupInputTextView()
        setupTableView()
        setupDoneButtonView()
        setupKeyboard()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(cancelButton)
        view.addSubview(inputTextView)
        view.addSubview(tableView)
        view.addSubview(doneButton)
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
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AddressInputCell.self, forCellReuseIdentifier: "addressInputCell")
        tableView.separatorStyle = .none
    }
    
    private func setupInputTextView() {
        inputTextView.backgroundColor = .systemGray6
        inputTextView.textContainerInset = UIEdgeInsets(
            top: 18,
            left: 12,
            bottom: 18,
            right: 12
        )
        inputTextView.layer.cornerRadius = 16
        inputTextView.clipsToBounds = true
        inputTextView.font = .systemFont(ofSize: 17)
    }
    
    private func setupDoneButtonView() {
        doneButton.backgroundColor = .systemBlue
        doneButton.layer.cornerRadius = 12
        doneButton.clipsToBounds = true
        doneButton.titleEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 18,
            bottom: 13,
            right: 18
        )
        doneButton.titleLabel?.font = .systemFont(ofSize: 15)
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

extension AddressInputViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressInputCell()
        cell.setPrimaryText("ул. Новотушинская, 1")
        cell.setSecondaryText("Московская обл., г. Красногорск, деревня Путилкино, д. 52")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}
