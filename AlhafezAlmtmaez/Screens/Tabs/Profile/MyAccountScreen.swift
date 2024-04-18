//
//  MyAccountScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 14/03/2024.
//

import UIKit

final class MyAccountScreen: BaseScreen {

    // MARK: - Properties

    private lazy var vm: MyAccountScreenVM = .init()

    // MARK: - Subviews

    private lazy var refreshControl: UIRefreshControl = .init()
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberValueLabel: UILabel!
    @IBOutlet weak var signoutLabel: UILabel!
    @IBOutlet weak var signoutStackView: UIStackView!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStrings()
        setupDynamicLayout()

        setupScollView()

        setupActions()
    }

    // MARK: - Bindings

    override func setupVMBindingsOnViewDidLoad() {
        vm.$isLoading
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &viewDidLoadBindings)

        vm.$onToastMessage
            .assign(to: \.onToastMessage, on: self)
            .store(in: &viewDidLoadBindings)
    }

    // MARK: - Actions

    private func setupActions() {
        refreshControl.addTarget(
            self, 
            action: #selector(doRefresh), 
            for: .valueChanged
        )

        signoutStackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(doSignOut)
            )
        )
    }

    @objc private func doRefresh() {
        
    }

    @objc private func doSignOut() {
        vm.signout()
    }
}

extension MyAccountScreen {
    private func setupStrings() {
        self.navigationItem.title = .text.PersonalPage
    }

    private func setupDynamicLayout() {
        nameLabel.font = .avenirArabic_800(size: 16)
        nameValueLabel.font = .avenirArabic_500(size: 16)
        phoneNumberLabel.font = .avenirArabic_800(size: 16)
        phoneNumberValueLabel.font = .avenirArabic_500(size: 16)
        signoutLabel.font = .avenirArabic_800(size: 16)
    }

    private func setupScollView() {
        scrollView.refreshControl = refreshControl
    }
}
