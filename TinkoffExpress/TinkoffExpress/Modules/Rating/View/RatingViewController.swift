//
//  RatingViewController.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 26.05.2023.
//

import UIKit

final class RatingViewController: UIViewController {
    // MARK: Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 218)
        view.backgroundColor = UIColor(named: "rating.background")
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("ratingViewQuestionLabel", comment: "")
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "rating.text1")
        return label
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.dropShadow(with: .medium)
        button.setTitle("Готово", for: .normal)
        button.backgroundColor = UIColor(named: "rating.button")
        button.setTitleColor(UIColor(named: "rating.text1"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var starsRating = StarsRatingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "modal.background")
        
        setupViewHierarchy()
        setupConstraints()
        setupShadow()
    }
    
    private func setupViewHierarchy() {
        self.view.addSubview(containerView)
        containerView.addSubview(questionLabel)
        containerView.addSubview(starsRating)
        containerView.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(218)
        }
        questionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
        }
        starsRating.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.top.equalTo(starsRating.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
        }
    }
    
    private func setupShadow() {
        containerView.dropShadow(
            offsetX: 0,
            offsetY: 0,
            color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
            opacity: 1,
            radius: 24
        )
    }
    
    @objc private func doneButtonTapped() {
        self.dismiss(animated: true)
    }
}
