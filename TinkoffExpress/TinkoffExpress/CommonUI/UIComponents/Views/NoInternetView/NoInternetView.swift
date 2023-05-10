//
//  NoInternetView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import UIKit

final class NoInternetView: UIView {
    // MARK: Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "noInternet")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Нет интернета"
        label.textColor = UIColor(named: "textColor2")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalToSuperview().offset(12)
        }
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalTo(imageView.snp.right).offset(12)
        }
    }
}
