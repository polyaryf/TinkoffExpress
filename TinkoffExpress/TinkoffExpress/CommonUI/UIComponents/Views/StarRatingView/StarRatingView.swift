//
//  StarRatingView.swift
//  TinkoffExpress
//
//  Created by Полина Рыфтина on 25.05.2023.
//

import UIKit

enum Rate {
    case one
    case two
    case three
    case four
    case five
}

final class StarsRatingView: UIView {
    // MARK: Subviews
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 11
        return stackView
    }()
    
    private lazy var firstStarView: StarImageView = {
        let imageView = StarImageView(
            rate: .one,
            image: UIImage(named: "star")!
        )
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var secondStarView: StarImageView = {
        let imageView = StarImageView(
            rate: .two,
            image: UIImage(named: "star")!
        )
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var thirdStarView: StarImageView = {
        let imageView = StarImageView(
            rate: .three,
            image: UIImage(named: "star")!
        )
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var fourthStarView: StarImageView = {
        let imageView = StarImageView(
            rate: .four,
            image: UIImage(named: "star")!
        )
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var fifthStarView: StarImageView = {
        let imageView = StarImageView(
            rate: .five,
            image: UIImage(named: "star")!
        )
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: GestureRecognizers
    
    private lazy var firstTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped(sender:)))
        return gesture
    }()
    
    private lazy var secondTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped(sender:)))
        return gesture
    }()
    
    private lazy var thirdTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped(sender:)))
        return gesture
    }()
    
    private lazy var fourthTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped(sender:)))
        return gesture
    }()
    
    private lazy var fifthTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped(sender:)))
        return gesture
    }()
    
    @objc private func imageTapped(sender: UITapGestureRecognizer) {
        guard let image = sender.view as? StarImageView else {
            print("cksdcks")
            return
        }
        switch image.rate {
        case .one:
            firstStarView.image = UIImage(named: "star.fill")
            secondStarView.image = UIImage(named: "star")
            thirdStarView.image = UIImage(named: "star")
            fourthStarView.image = UIImage(named: "star")
            fifthStarView.image = UIImage(named: "star")
        case .two:
            firstStarView.image = UIImage(named: "star.fill")
            secondStarView.image = UIImage(named: "star.fill")
            thirdStarView.image = UIImage(named: "star")
            fourthStarView.image = UIImage(named: "star")
            fifthStarView.image = UIImage(named: "star")
        case .three:
            firstStarView.image = UIImage(named: "star.fill")
            secondStarView.image = UIImage(named: "star.fill")
            thirdStarView.image = UIImage(named: "star.fill")
            fourthStarView.image = UIImage(named: "star")
            fifthStarView.image = UIImage(named: "star")
        case .four:
            firstStarView.image = UIImage(named: "star.fill")
            secondStarView.image = UIImage(named: "star.fill")
            thirdStarView.image = UIImage(named: "star.fill")
            fourthStarView.image = UIImage(named: "star.fill")
            fifthStarView.image = UIImage(named: "star")
        case .five:
            firstStarView.image = UIImage(named: "star.fill")
            secondStarView.image = UIImage(named: "star.fill")
            thirdStarView.image = UIImage(named: "star.fill")
            fourthStarView.image = UIImage(named: "star.fill")
            fifthStarView.image = UIImage(named: "star.fill")
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initial Configuration
    
    private func setupViews() {
        firstStarView.addGestureRecognizer(firstTapGestureRecognizer)
        secondStarView.addGestureRecognizer(secondTapGestureRecognizer)
        thirdStarView.addGestureRecognizer(thirdTapGestureRecognizer)
        fourthStarView.addGestureRecognizer(fourthTapGestureRecognizer)
        fifthStarView.addGestureRecognizer(fifthTapGestureRecognizer)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(firstStarView)
        stackView.addArrangedSubview(secondStarView)
        stackView.addArrangedSubview(thirdStarView)
        stackView.addArrangedSubview(fourthStarView)
        stackView.addArrangedSubview(fifthStarView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        firstStarView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        secondStarView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        thirdStarView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        fourthStarView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        fifthStarView.snp.makeConstraints { 
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
    }
}

class StarImageView: UIImageView {
    var rate: Rate = .one

    required convenience init(rate: Rate, image: UIImage) {
        self.init(image: image)

        self.rate = rate
    }

    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class StarRatingView: UIImageView {
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(imageTapped))
        return gesture
    }()
    
    // MARK: State
    
    private var isTapped = false
    
    // MARK: Init
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.isUserInteractionEnabled = true
        self.contentMode = .scaleAspectFit
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func imageTapped() {
        if isTapped {
            image = UIImage(named: "star")
            isTapped = false
        } else {
            isTapped = true
            image = UIImage(named: "star.fill")
        }
    }
}
