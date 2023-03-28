//
//  OnboardingViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 28.03.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private var onboardingPresenter: OnboardingPresenterProtocol?
    
    // MARK: Properties
    
    lazy var items: [Onboarding] = []
    
    // MARK: Subviews
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var continueButton = UIButton()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingPresenter?.viewDidLoad()

        setupCollectionView()
        setupContinueButton()
        setupColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Actions
    
    @objc private func continueButtonTapped() {
        onboardingPresenter?.continueButtonTapped()
    }
    
    @objc private func continueButtonTouchDown() {
        onboardingPresenter?.continueButtonTouchDown(with: continueButton)
    }
    
    @objc private func continueButtonTouchUpInside() {
        onboardingPresenter?.continueButtonTouchUpInside(with: continueButton)
    }
    
    // MARK: Setup Dependencies
    
    func setPresenter(_ presenter: OnboardingPresenterProtocol) {
        self.onboardingPresenter = presenter
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "onboardingBackgroundColor")
        collectionView.backgroundColor = UIColor(named: "onboardingBackgroundColor")
        continueButton.backgroundColor = UIColor(named: "yellowButtonColor")
    }
    
    // MARK: Setup Subviews

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.delaysContentTouches = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.register(
            OnboardingHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "OnboardingHeaderView")

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContinueButton() {
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.layer.cornerRadius = 16
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTouchDown), for: .touchDown)
        continueButton.addTarget(self, action: #selector(continueButtonTouchUpInside), for: .touchUpInside)
        
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.height.equalTo(56)
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next superfluous_disable_command
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath)
        // swiftlint:disable:next force_cast
        as! OnboardingCell
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
        return CGSize(width: collectionView.bounds.width, height: 88)
    }

    // Header
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // swiftlint:disable:next line_length
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OnboardingHeaderView", for: indexPath)
            // swiftlint:disable:next force_cast
            as! OnboardingHeaderView
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
        return 0
    }
}
