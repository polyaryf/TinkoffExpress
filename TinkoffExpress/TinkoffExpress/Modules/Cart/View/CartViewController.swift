//
//  CartViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private var cartPresenter: CartPresenterProtocol
    
    // MARK: Properties
    
    lazy var items: [Cart] = []
    
    // MARK: Subviews
    private lazy var countLabel = UILabel()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var finalView = UIView()
    private lazy var priceLabel = UILabel()
    private lazy var finalLabel = UILabel()
    private lazy var checkoutButton = UIButton()
    
    // MARK: Init
    
    init(cartPresenter: CartPresenterProtocol) {
        self.cartPresenter = cartPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartPresenter.viewDidLoad()
        
        setupNavigationItem()
        setupCountLabel()
        setupCollectionView()
        setupFinalView()
        setupColors()
    }
    
    // MARK: Actions
    
    @objc private func checkoutButtonTapped() {
        cartPresenter.checkoutButtonTapped()
    }
    
    @objc private func checkoutButtonTouchDown() {
        cartPresenter.checkoutButtonTouchDown(with: checkoutButton)
    }
    
    @objc private func checkoutButtonTouchUpInside() {
        cartPresenter.checkoutButtonTouchUpInside(with: checkoutButton)
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        countLabel.textColor = UIColor(named: "textColor")
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        finalView.backgroundColor = UIColor(named: "finalViewColor")
        priceLabel.textColor = UIColor(named: "textColor")
        checkoutButton.backgroundColor = UIColor(named: "yellowButtonColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupNavigationItem() {
        navigationItem.title = "Корзина"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "trash"),
            style: .done,
            target: self,
            action: nil
        )
    }
    
    private func setupCountLabel() {
        countLabel.text = "\(items.count) товаров"
        countLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(26)
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .white
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupFinalView() {
        finalView.layer.cornerRadius = 20
        
        finalView.layer.shadowColor = UIColor.black.cgColor
        finalView.layer.shadowOpacity = 0.1
        finalView.layer.shadowOffset = CGSize(width: 0, height: 2)
        finalView.layer.shadowRadius = 4
        
        view.addSubview(finalView)
        
        finalView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(80)
        }
        
        priceLabel.text = "3 556 ₽"
        priceLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        finalView.addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-38)
            make.width.equalTo(82)
        }
        
        finalLabel.text = "Итоговая стоимость"
        finalLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        finalLabel.textColor = UIColor(named: "finalLabelColor")
        
        finalView.addSubview(finalLabel)
        
        finalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(212)
        }
        
        checkoutButton.setTitle("Оформить", for: .normal)
        checkoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        checkoutButton.setTitleColor(.black, for: .normal)
        checkoutButton.layer.cornerRadius = 15
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTouchDown), for: .touchDown)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTouchUpInside), for: .touchUpInside)
        
        finalView.addSubview(checkoutButton)
        
        checkoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-34)
            make.width.equalTo(111)
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CartCell", for: indexPath
        ) as? CartCell {
            let textCell = items[indexPath.row].text
            let imageNameCell = items[indexPath.row].imageName
            cell.setupCell(text: textCell, imageName: imageNameCell)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 36, height: 72)
    }
}
