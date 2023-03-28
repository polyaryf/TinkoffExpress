//
//  DeliveryViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit
// swiftlint:disable:next line_length
final class DeliveryViewController: UIViewController, Modulated, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private var deliveryPresenter: DeliveryPresenterProtocol?
    
    // MARK: Properties
    
    lazy var items: [Delivery] = []

    // MARK: Subviews
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var closeButton = UIButton(type: .system)
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deliveryPresenter?.viewDidLoad()
        
        setupCloseButton()
        setupCollectionView()
        setupColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "deliveryBackgroundColor")
        collectionView.backgroundColor = UIColor(named: "deliveryBackgroundColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupCloseButton() {
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(closeButton)

        // Add Constraints using SnapKit
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
        }
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.delaysContentTouches = false
        collectionView.register(DeliveryCell.self, forCellWithReuseIdentifier: "DeliveryCell")
        collectionView.register(
            DeliveryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "DeliveryHeaderView")

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(13)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next superfluous_disable_command
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCell", for: indexPath)
        // swiftlint:disable:next force_cast
        as! DeliveryCell
        let textCell = items[indexPath.row].text
        let imageNameCell = items[indexPath.row].imageName
        cell.setupCell(text: textCell, imageName: imageNameCell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 72)
    }

    // Header
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // swiftlint:disable:next line_length
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DeliveryHeaderView", for: indexPath)
            // swiftlint:disable:next force_cast
            as! DeliveryHeaderView
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 104)
    }
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
