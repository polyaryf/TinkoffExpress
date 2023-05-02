//
//  ABTestView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

final class ABTestView: UIView {
    // MARK: Subviews
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    private lazy var containerView = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton.init()
        button.backgroundColor = UIColor(named: "blue.color")
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(
            top: 13,
            left: 18,
            bottom: 13,
            right: 18
        )
        button.isHidden = true
        return button
    }()
    
    // MARK: State
    
    var currentTextField: TextField?
    var address: ABInputAddress
    var isAddressValid: Bool
    
    // MARK: Init
    
    override init(frame: CGRect) {
        self.address = ABInputAddress(
            country: "",
            region: "",
            street: "",
            house: "",
            settlement: "",
            postalСode: "")
        self.isAddressValid = false
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setStackView()
    }
    
    private func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        self.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview().inset(16)
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
            $0.width.equalTo(84)
        }
    }
    
    private func setStackView() {
        [
            createTextField(with: .country),
            createTextField(with: .region),
            createTextField(with: .street),
            createTextField(with: .house),
            createTextField(with: .settlement),
            createTextField(with: .postalCode)
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        stackView.spacing = 16
    }
    
    private func createTextField(with type: ABTestType) -> TextField {
        let textField = TextField()
        textField.modifyClearButtonWithImage(
            image: UIImage(named: "x.cross.addressInput")
        )
        textField.tintColor = UIColor(named: "blue.color")
        textField.backgroundColor = UIColor(named: "inputTextView.abtest.color")
        textField.textColor = UIColor(named: "inputText.abtest.color")
        textField.font = .systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 16
        textField.clipsToBounds = true
        textField.delegate = self
        textField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(_:)),
            for: UIControl.Event.editingChanged
        )
        
        switch type {
        case .country:
            textField.placeholder = "Страна"
            textField.returnKeyType = .next
        case .region:
            textField.placeholder = "Регион"
            textField.returnKeyType = .next
        case .street:
            textField.placeholder = "Улица"
            textField.returnKeyType = .next
        case .house:
            textField.placeholder = "Строение/корпус"
            textField.returnKeyType = .next
        case .settlement:
            textField.placeholder = "Населенный пункт"
            textField.returnKeyType = .next
        case .postalCode:
            textField.placeholder = "Индекс"
            textField.returnKeyType = .done
        }
        return textField
    }
    
    // MARK: Validation
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if isValid(at: textField) {
            textField.textColor = UIColor(named: "inputText.abtest.color")
            isAddressValid = true
        } else {
            textField.textColor = .red
            isAddressValid = false
        }
    }
    
    private func isValid(at textField: UITextField) -> Bool {
        let type = getType(for: textField)
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        switch type {
        case .country:
            return isValidCharOnly(with: text)
        case .region:
            return isValidCharOnly(with: text)
        case .street:
            return true
        case .house:
            return true
        case .settlement:
            return true
        case .postalCode:
            return isValidNundersOnly(with: text)
        }
    }
    
    private func isValidCharOnly(with text: String) -> Bool {
        let set = CharacterSet(charactersIn: text)
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        let decimalRange = text.rangeOfCharacter(from: digitsCharacters)
        return !(decimalRange != nil)
    }
    
    private func isValidNundersOnly(with text: String) -> Bool {
        let set = CharacterSet(charactersIn: text)
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: text)
        return digitsCharacters.isSuperset(of: characterSet)
    }
    
    // MARK: Public
    
    func nextViewBecomeFirstResponder(after textField: UITextField) -> Bool {
        let arrangedSubviews = stackView.arrangedSubviews
        if let index = arrangedSubviews.firstIndex(of: textField) {
            setAddress(with: getType(for: textField), from: textField)
            if index == 5 {
                arrangedSubviews[5].becomeFirstResponder()
                return false
            }
            arrangedSubviews[index + 1].becomeFirstResponder()
            return true
        }
        return false
    }
    
    func setAddress(with type: ABTestType, from textField: UITextField) {
        let text = textField.text ?? ""
        switch type {
        case .country:
            address.country = text
        case .region:
            address.region = text
        case .street:
            address.street = text
        case .house:
            address.house = text
        case .settlement:
            address.settlement = text
        case .postalCode:
            address.postalСode = text
        }
    }
    
    func getType(for textField: UITextField) -> ABTestType {
        let textFields = stackView.arrangedSubviews.compactMap {
            $0 as? TextField
        }
        if textField === textFields[0] {
            return .country
        } else if textField === textFields[1] {
            return .region
        } else if textField === textFields[2] {
            return .street
        } else if textField === textFields[3] {
            return .house
        } else if textField === textFields[4] {
            return .settlement
        } else {
            return .postalCode
        }
    }
    
    func checkDoneButton() {
        if currentTextField === stackView.arrangedSubviews.last {
            doneButton.setTitle("Готово", for: .normal)
        } else {
            doneButton.setTitle("Далее", for: .normal)
        }
    }
}
