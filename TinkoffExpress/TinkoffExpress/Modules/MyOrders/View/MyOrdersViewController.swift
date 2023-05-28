//
//  MyOrdersViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 23.04.2023.
//

import UIKit
import SnapKit

protocol IMyOrdersViewController: AnyObject {
    func showNotificationView()
    func updateView(with items: [MyOrder])
    func startLoading()
    func stopLoading()
    func showErrorAlert()
}

final class MyOrdersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Dependencies
    
    private let myOrdersPresenter: MyOrdersPresenterProtocol
    
    // MARK: Properties
    
    private var items: [MyOrder] = []
    
    // MARK: Subviews
   
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var notificationView = NotificationView()
    private lazy var activityIndicatorView: ActivityIndicatorView = {
        let view = ActivityIndicatorView(style: .mYellow)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init
    
    init(myOrdersPresenter: MyOrdersPresenterProtocol) {
        self.myOrdersPresenter = myOrdersPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        myOrdersPresenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        setupColors()
        setupNotificationView()
        setupActivityIndicatorView()
        
        myOrdersPresenter.viewDidLoad()
    }
    
    // MARK: Actions
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myOrdersPresenter.didSelect(item: items[indexPath.row])
    }
    
    // MARK: Setup Colors
    
    private func setupColors() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    // MARK: Setup Subviews
    
    private func setupNavigationBar() {
        navigationItem.title = NSLocalizedString("myOrdersTitle", comment: "")
        navigationItem.backButtonTitle = ""
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.delaysContentTouches = false
        collectionView.register(MyOrdersCell.self, forCellWithReuseIdentifier: "MyOrdersCell")
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNotificationView() {
        notificationView.isHidden = true
        view.addSubview(notificationView)
        
        notificationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.isHidden = true
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.notificationView {
            notificationView.isHidden = true
        }
    }
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MyOrdersCell",
            for: indexPath
        ) as? MyOrdersCell {
            let descriptionCell = items[indexPath.row].description
            let imageNameCell = items[indexPath.row].imageName
            cell.setupCell(description: descriptionCell, imageName: imageNameCell)
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

extension MyOrdersViewController: IMyOrdersViewController {
    func showNotificationView() {
        notificationView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [notificationView] in
            notificationView.isHidden = true
        }
    }
    
    func updateView(with items: [MyOrder]) {
        self.items = items
        collectionView.reloadData()
    }
    
    func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimation(animated: true)
    }
    
    func stopLoading() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimation(animated: true)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController.defaultErrorAlert()
        self.present(alert, animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension MyOrdersViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
