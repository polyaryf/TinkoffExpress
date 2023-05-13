//
//  SettingsViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 06.05.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private let settingsPresenter: SettingsPresenterProtocol
    
    // MARK: Properties
    
    private let items: [Settings] = [
        Settings(
            text: NSLocalizedString("settingsCellText", comment: ""),
            description: NSLocalizedString("searchTypeStandard", comment: ""),
            imageName: "myOrdersDeliveryImage",
            isActive: true
        )
    ]
    
    // MARK: Subviews
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: Init
    
    init(settingsPresenter: SettingsPresenterProtocol) {
        self.settingsPresenter = settingsPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = NSLocalizedString("settingsTitle", comment: "")
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.delaysContentTouches = false
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: "SettingsCell")
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SettingsCell",
            for: indexPath
        ) as? SettingsCell {
            let textCell = items[indexPath.row].text
            let descriptionCell = items[indexPath.row].description
            let imageNameCell = items[indexPath.row].imageName
            let isActiveCell = items[indexPath.row].isActive
            cell.setupCell(
                text: textCell,
                description: descriptionCell,
                imageName: imageNameCell,
                isActive: isActiveCell
            )
            cell.onToggleSwitchDidChange { [settingsPresenter] flag in
                settingsPresenter.viewToggleSwitchDidChange(with: flag)
            }
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
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }
}
