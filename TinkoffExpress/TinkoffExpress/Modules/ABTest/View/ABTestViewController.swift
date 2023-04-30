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
    
    var address: ABInputAddress
    
    // MARK: Dependency
    
    private var presenter: ABTestPresenterProtocol
    
    // MARK: Init
        
    init(presenter: ABTestPresenterProtocol) {
        self.address = ABInputAddress(
            country: "",
            region: "",
            street: "",
            settlement: "",
            postalСode: "")
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
        setupTextViews()
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
    
    private func setupTextViews() {
        setupTextView(textView: mainView.countryTextView, with: .country)
        setupTextView(textView: mainView.regionTextView, with: .region)
        setupTextView(textView: mainView.streetTextView, with: .street)
        setupTextView(textView: mainView.houseTextView, with: .house)
        setupTextView(textView: mainView.settlementTextView, with: .settlement)
        setupTextView(textView: mainView.postalСodeTextView, with: .postalCode)
    }
    
    private func setupTextView(textView: TextView, with type: ABTextViewType) {
        trackTextViewChanges(at: textView)
        textView.setClearButton(
            superViewSize: CGRect(
                origin: .zero,
                size: CGSize(width: 343, height: 56)
            )
        )
        // TODO: ask about this issue
        guard let clearButton = textView.subviews.last as? UIButton else { return }
        clearButton.addTarget(
            self,
            action: #selector(clearButtonTapped(_:)),
            for: .touchUpInside
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
    
    @objc func clearButtonTapped(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        guard let textView = button.superview as? TextView else { return }
        textView.text = ""
        
        textView.checkPlaceholder()
        textView.checkClearTextButton()
    }
    
    @objc func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
    
    @objc func doneButtonTapped() {
        presenter.doneButtonTapped()
    }
    
    // MARK: Keyboard
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        let keyboardHeight = keyboardFrame.size.height
         
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

extension ABTestViewController: ABTestViewControllerProtocol {
    func closeABTestView() {
        self.dismiss(animated: true)
    }
}

extension ABTestViewController {
    private func trackTextViewChanges(at view: TextView) {
        view.textDidChangeHandler = { [weak self] in
            guard let self = self else { return }
            guard let inputText = view.text else { return }
        }
    }
}
