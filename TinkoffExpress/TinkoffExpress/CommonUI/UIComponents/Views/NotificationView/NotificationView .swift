//
//  NotificationView .swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 10.05.2023.
//

import UIKit

final class NotificationView: UIView {
    // MARK: Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 184, height: 138)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "notification.background")
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check-circle-positive")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("notificationViewLabelText", comment: "")
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(named: "myOrdersDeliveryTextColor")
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initial Configuration
    
    private func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupShadow()
    }
    
    private func setupShadow() {
        containerView.dropShadow(
            offsetX: 0,
            offsetY: 0,
            color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
            opacity: 1,
            radius: 34
        )
    }
    
    private func setupViewHierarchy() {
        self.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(184)
            $0.height.equalTo(138)
        }
        imageView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

extension UIView {
    func dropShadow(
        offsetX: CGFloat,
        offsetY: CGFloat,
        color: UIColor,
        opacity: Float,
        radius: CGFloat,
        scale: Bool = true
    ) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
