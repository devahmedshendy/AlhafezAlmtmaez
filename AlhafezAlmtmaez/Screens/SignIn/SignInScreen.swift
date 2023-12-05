//
//  SignInScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 13/11/2023.
//

import UIKit

final class SignInScreen: BaseScrollableFormScreen {

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
    }
}

// MARK: - View Setup

extension SignInScreen {
    private func setupStrings() {
        self.navigationItem.title = .text.signin

        submitButton.title = .text.signin
    }

    private func setupDynamicLayout() {
        fieldsStackTopConstraint.constant = .dynamicToWidth(48)
        fieldsStackBottomConstraint.constant = .dynamicToWidth(80)
        scrollContentBottomConstraint.constant = .dynamicToWidth(34)
    }
}
