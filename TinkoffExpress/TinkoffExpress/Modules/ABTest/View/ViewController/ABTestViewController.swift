//
//  ABTestViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

protocol ABTestViewControllerProtocol: AnyObject {
    func closeABTestView()
}

final class ABTestViewController: UIViewController {
    // MARK: View
    
    private lazy var mainView = ABTestView()
      
    // MARK: State
    
    var address: ABInputAddress?
    
    // MARK: Dependency
    
    private let presenter: ABTestPresenterProtocol

    // MARK: Init
        
    init(
        presenter: ABTestPresenterProtocol
    ) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.stackView.arrangedSubviews[0].becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Private
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background.abtest.color")
        
        setupNavigationItem()
        setupKeyboard()
        addDoneButtonTarget()
    }
    
    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отмена",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
    }
    
    private func addDoneButtonTarget() {
        mainView.doneButton.addTarget(
            self,
            action: #selector(doneButtonTapped),
            for: .touchUpInside
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
    
    @objc func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    @objc func doneButtonTapped() {
        guard let textField = mainView.currentTextField else { return }
        guard mainView.isAddressValid else { return }
        guard mainView.nextViewBecomeFirstResponder(after: textField) else {
            address = mainView.address
            presenter.doneButtonTapped(with: address)
            return
        }
    }
    
    // MARK: Keyboard
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        let keyboardHeight = keyboardFrame.size.height
        var contentInset: UIEdgeInsets = mainView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        mainView.scrollView.contentInset = contentInset
         
        UIView.animate(withDuration: duration) { [self] in
            mainView.doneButton.isHidden = false
            mainView.doneButton.snp.remakeConstraints {
                $0.bottom.equalToSuperview().offset(-(keyboardHeight + 16))
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        let contentInset = UIEdgeInsets.zero
        mainView.scrollView.contentInset = contentInset
        
        UIView.animate(withDuration: duration) { [self] in
            mainView.doneButton.isHidden = true
            mainView.doneButton.snp.remakeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
                $0.trailing.equalToSuperview().offset(-16)
                $0.height.equalTo(44)
                $0.width.equalTo(84)
            }
            view.layoutIfNeeded()
        }
    }
}

// MARK: - ABTestViewControllerProtocol

extension ABTestViewController: ABTestViewControllerProtocol {
    func closeABTestView() {
        self.dismiss(animated: true)
    }
}
