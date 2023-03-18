//
//  OnboardingViewController.swift
//  TinkoffExpress
//
//  Created by zedsbook on 18.03.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    var onboardingPresenter: OnboardingPresenterProtocol?
}

// MARK: - Life Cycle
extension OnboardingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Setup
extension OnboardingViewController {
    func setPresenter(_ presenter: OnboardingPresenterProtocol) {
        self.onboardingPresenter = presenter
    }
}
