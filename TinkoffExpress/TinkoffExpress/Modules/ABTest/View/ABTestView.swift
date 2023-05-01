//
//  ABTestView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 30.04.2023.
//

import UIKit

final class ABTestView: UIView {
    lazy var countryTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var regionTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var streetTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var houseTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var settlementTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var postalСodeTextView: TextView = {
        let textView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton.init()
        button.backgroundColor = UIColor(named: "blue.color")
        button.setTitle("Готово", for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupTextViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(countryTextView)
        self.addSubview(regionTextView)
        self.addSubview(streetTextView)
        self.addSubview(houseTextView)
        self.addSubview(settlementTextView)
        self.addSubview(postalСodeTextView)
        self.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        countryTextView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        regionTextView.snp.makeConstraints {
            $0.top.equalTo(countryTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        streetTextView.snp.makeConstraints {
            $0.top.equalTo(regionTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        houseTextView.snp.makeConstraints {
            $0.top.equalTo(streetTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        settlementTextView.snp.makeConstraints {
            $0.top.equalTo(houseTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        postalСodeTextView.snp.makeConstraints {
            $0.top.equalTo(settlementTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
            $0.width.equalTo(84)
        }
    }
    
    private func setupTextViews() {
        setupTextView(textView: countryTextView, with: .country)
        setupTextView(textView: regionTextView, with: .region)
        setupTextView(textView: streetTextView, with: .street)
        setupTextView(textView: houseTextView, with: .house)
        setupTextView(textView: settlementTextView, with: .settlement)
        setupTextView(textView: postalСodeTextView, with: .postalCode)
    }
    
    private func setupTextView(textView: TextView, with type: ABTextViewType) {
        textView.textContainer.maximumNumberOfLines = 1
        textView.tintColor = UIColor(named: "blue.color")
        textView.backgroundColor = UIColor(named: "inputTextView.abtest.color")
        textView.textColor = UIColor(named: "inputText.abtest.color")
        textView.font = .systemFont(ofSize: 17)
        textView.showsVerticalScrollIndicator = false
        textView.layer.cornerRadius = 16
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(
            top: 18,
            left: 14,
            bottom: 18,
            right: 28
        )
        switch type {
        case .country:
            textView.setPlaceholder(with: "Страна")
        case .region:
            textView.setPlaceholder(with: "Регион")
        case .street:
            textView.setPlaceholder(with: "Улица")
        case .house:
            textView.setPlaceholder(with: "Строение/корпус")
        case .settlement:
            textView.setPlaceholder(with: "Населенный пункт")
        case .postalCode:
            textView.setPlaceholder(with: "Индекс")
        }
    }
}
