//
//  DeliveryViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class DeliveryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private var deliveryPresenter: DeliveryPresenterProtocol?

    // MARK: Subviews
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var closeButton = UIButton(type: .system)
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCloseButton()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Actions
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deliveryPresenter?.didSelectItemAt()
    }
    
    // MARK: Setup Dependencies
    
    func setPresenter(_ presenter: DeliveryPresenterProtocol) {
        self.deliveryPresenter = presenter
    }
    
    // MARK: Setup Subviews
    
    private func setupCloseButton() {
        closeButton.setTitle("Закрыть", for: .normal)

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(closeButton)

        // Add Constraints using SnapKit
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
        }
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .white
        collectionView.register(DeliveryCell.self, forCellWithReuseIdentifier: "DeliveryCell")
        collectionView.register(
            DeliveryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "DeliveryHeaderView")

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCell", for: indexPath) as! DeliveryCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: 70)
    }

    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // swiftlint:disable:next force_cast
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DeliveryHeaderView", for: indexPath) as! DeliveryHeaderView
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 90)
    }
}
