//
//  OnboardingViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private var onboardingPresenter: OnboardingPresenterProtocol?
    
    // MARK: Subviews
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var continueButton = UIButton()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupCollectionView()
        setupContinueButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Actions
    
    @objc private func continueButtonTapped() {
        onboardingPresenter?.continueButtonTapped()
    }
    
    // MARK: Setup Dependencies
    
    func setPresenter(_ presenter: OnboardingPresenterProtocol) {
        self.onboardingPresenter = presenter
    }
    
    // MARK: Setup Subviews

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .white
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.register(
            OnboardingHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "OnboardingHeaderView")

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupContinueButton() {
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.layer.cornerRadius = 15
        continueButton.backgroundColor = .systemYellow
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(55)
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }

    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // swiftlint:disable:next force_cast
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OnboardingHeaderView", for: indexPath) as! OnboardingHeaderView
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 90)
    }
}
