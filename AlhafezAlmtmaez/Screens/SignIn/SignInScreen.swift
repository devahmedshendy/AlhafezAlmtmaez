//
//  SignInScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 13/11/2023.
//

import UIKit

final class SignInScreen: BaseScrollableFormScreen {

    // MARK: - Properties

    private lazy var vm: SignInScreenVM = .init()

    private var phoneNumber: String { phoneNumberFieldView.text }

    // MARK: - Constraints

    @IBOutlet weak var scrollContentBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldsStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldsStackBottomConstraint: NSLayoutConstraint!

    // MARK: - Subviews

    @IBOutlet weak var phoneNumberFieldView: PhoneNumberFieldView!
    @IBOutlet weak var submitButton: FormSubmitButton!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStrings()
        setupDynamicLayout()

        #if DEBUG
        phoneNumberFieldView.text = "0780327211"
        #endif
    }

    // MARK: - Bindings

    override func setupVMBindingsOnViewDidLoad() {
        vm.$isLoading
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
                self?.submitButton.isEnabled = isLoading == false
            }
            .store(in: &viewDidLoadBindings)

        vm.$onToastMessage
            .assign(to: \.onToastMessage, on: self)
            .store(in: &viewDidLoadBindings)

        vm.$onValidation
            .sink { [weak self] validation in
                self?.phoneNumberFieldView.error = validation[.validation.phoneNumber]
            }
            .store(in: &viewDidLoadBindings)

        vm.$onRequestResult
            .sink { [weak self] result in
                guard let self = self else { return }

                self.goToVerifyCodeScreen(
                    phoneNumber: phoneNumber,
                    result: result
                )
            }
            .store(in: &viewDidLoadBindings)
    }

    // MARK: - Actions

    @IBAction func doSignin(_ sender: UIButton) {
        vm.doSignIn(phoneNumber: phoneNumber)
    }
}

// MARK: - View Setup

extension SignInScreen {
    private func setupStrings() {
        self.navigationItem.title = .text.SignIn

        submitButton.title = .text.SignIn
    }

    private func setupDynamicLayout() {
        fieldsStackTopConstraint.constant = .dynamicToWidth(48)
        fieldsStackBottomConstraint.constant = .dynamicToWidth(80)
        scrollContentBottomConstraint.constant = .dynamicToWidth(45)
    }
}
