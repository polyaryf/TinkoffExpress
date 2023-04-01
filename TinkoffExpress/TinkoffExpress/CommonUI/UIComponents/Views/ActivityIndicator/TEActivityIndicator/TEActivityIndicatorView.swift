//
//  TEActivityIndicatorView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 28.03.2023.
//

import UIKit
import SnapKit

final class TEActivityIndicatorView: UIView {
    // MARK: Subviews
    
    private var activityIndicator: ActivityIndicatorView = .init(style: .mYellow)
    private var backgroundView = UIView(frame: CGRect(
        origin: .zero,
        size: CGSize(
        width: TEActivityIndicatorView.Constants.backgroundViewSide,
        height: TEActivityIndicatorView.Constants.backgroundViewSide)
        )
    )
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        self.backgroundColor = .clear
        setupViewHierarchy()
        setupConstraints()
        setUpSubviewsView()
    }
    
    private func setupViewHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self)
            $0.width.height.greaterThanOrEqualTo(TEActivityIndicatorView.Constants.backgroundViewSide)
        }
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView)
            $0.centerY.equalTo(backgroundView)
        }
    }
    
    private func setUpSubviewsView() {
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = TEActivityIndicatorView.Constants.backgroundViewCornerRadius
    }
}

private extension TEActivityIndicatorView {
    enum Constants {
        static let backgroundViewSide: Int = 80
        static let backgroundViewCornerRadius: CGFloat = 20
    }
}
