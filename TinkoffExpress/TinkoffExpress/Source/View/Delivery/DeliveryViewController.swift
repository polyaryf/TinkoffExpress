//
//  DeliveryViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class DeliveryViewController: UIViewController {
    var deliveryPresenter: DeliveryPresenterProtocol?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let closeButton = UIButton(type: .system)
}

// MARK: - Life Cycle
extension DeliveryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCloseButton()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Actions
extension DeliveryViewController {
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deliveryPresenter?.showOnboarding()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension DeliveryViewController: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout {
    // Displaying CustomCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCell", for: indexPath) as! DeliveryCell
        return cell
    }

    // Number of Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    // Cells size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: 80)
    }

    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! DeliveryHeaderView
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }

    // Header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 110)
    }
}

// MARK: - Setup
extension DeliveryViewController {
    func setupCloseButton() {
        // Configure closeButton
        closeButton.setTitle("Закрыть", for: .normal)

        // Add Target
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        // Add Subview
        view.addSubview(closeButton)

        // Add Constraints using SnapKit
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }

    func setupCollectionView() {
        // Assignment to DataSource and Delegate
        collectionView.dataSource = self
        collectionView.delegate = self

        // Configure collectionView
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .white
        collectionView.register(DeliveryCell.self, forCellWithReuseIdentifier: "DeliveryCell")
        collectionView.register(
            DeliveryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView")

        // Add Subview
        view.addSubview(collectionView)

        // Add Constraints using SnapKit
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setPresenter(_ presenter: DeliveryPresenterProtocol) {
        self.deliveryPresenter = presenter
    }
}
