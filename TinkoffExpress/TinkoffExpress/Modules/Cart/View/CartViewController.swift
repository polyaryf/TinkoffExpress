//
//  CartViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    // MARK: Subviews
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor(named: "textColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(items.count) товаров"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .white
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        return collectionView
    }()
    
    private lazy var finalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.backgroundColor = UIColor(named: "finalViewColor")
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var finalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итоговая стоимость"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(named: "finalLabelColor")
        return label
    }()
    
    private lazy var checkoutButton = UIButton()
    
    // MARK: Dependency
    
    private var cartPresenter: CartPresenterProtocol
    
    // MARK: Properties
    
    private var items: [CartItem] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartPresenter.viewDidLoad()
        var totalCount = 0
        var totalSum = 0
        items.forEach { cart in
            totalCount += Int(cart.count) ?? 0
        }
        countLabel.text = "\(totalCount) товаров"
        priceLabel.text = "\(totalSum)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: Setup Subviews
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupNavigationItem()
        setupViewHierarchy()
        setupConstraints()
        setupCheckoutButton()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Корзина"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "trash"),
            style: .done,
            target: self,
            action: nil
        )
    }
    
    private func setupViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(countLabel)
        view.addSubview(finalView)
        finalView.addSubview(priceLabel)
        finalView.addSubview(finalLabel)
        finalView.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(26)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        finalView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(80)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-38)
            make.width.equalTo(82)
        }
        finalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-18)
            make.width.equalTo(212)
        }
        checkoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-34)
            make.width.equalTo(111)
        }
    }
    
    private func setupCheckoutButton() {
        checkoutButton.backgroundColor = UIColor(named: "yellowButtonColor")
        checkoutButton.setTitle("Оформить", for: .normal)
        checkoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        checkoutButton.setTitleColor(.black, for: .normal)
        checkoutButton.layer.cornerRadius = 15
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTouchDown), for: .touchDown)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Public
    
    func setItems(with items: [CartItem]) {
        self.items = items
        collectionView.reloadData()
    }
    
    // MARK: Actions
    
    @objc private func checkoutButtonTapped() {
        cartPresenter.checkoutButtonTapped()
    }
    
    @objc private func checkoutButtonTouchDown() {
        checkoutButton.backgroundColor = UIColor(named: "yellowButtonPressedColor")
    }
    
    @objc private func checkoutButtonTouchUpInside() {
        checkoutButton.backgroundColor = UIColor(named: "yellowButtonColor")
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
 
extension CartViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CartCell", for: indexPath
        ) as? CartCell {
            let textCell = items[indexPath.row].text
            let imageNameCell = items[indexPath.row].imageName
            let count = items[indexPath.row].count
            cell.set(text: textCell, imageName: imageNameCell, count: count)
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
