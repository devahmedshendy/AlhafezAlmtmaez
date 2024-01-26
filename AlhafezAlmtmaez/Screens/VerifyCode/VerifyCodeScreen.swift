//
//  VerifyCodeScreen.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 06/12/2023.
//

import UIKit

final class VerifyCodeScreen: BaseScrollableFormScreen {

    // MARK: - Properties

    var phoneNumber: String!
    var verifyToken: String!

    private lazy var otpValidityManager: OTPValidityManager = .init()

    // MARK: - Constraints

    @IBOutlet weak var scrollContentBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var sentToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sentToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var otpStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var otpStackBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var resendStackTopConstraint: NSLayoutConstraint!
    
    // MARK: - Subviews

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var sentToLabel: UILabel!
    @IBOutlet weak var sentToStackView: UIStackView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var changePhoneNumberQuestionButton: UnderlinedButton!
    @IBOutlet weak var resendStackView: UIStackView!
    @IBOutlet weak var otpTimeLabel: UILabel!
    @IBOutlet weak var otpQuestionLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!

    @IBOutlet weak var verifyButton: FormSubmitButton!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStrings()
        setupDynamicLayout()

        otpValidityManager.delegate = self

        doApplyInitialLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        otpValidityManager.start()
    }

    // MARK: - Actions

    @IBAction func doChangePhoneNumber(_ sender: UIButton) {
        
    }
    
    @IBAction func doVerify(_ sender: Any) {

    }

    private func doApplyInitialLayout() {
        resendStackView.isHidden = true
        resendButton.isHidden = true
    }

    private func doApplyTimerStartedLayout() {
        resendStackView.isHidden = false
        resendButton.isHidden = true
    }

    private func doApplyTimerFinishedLayout() {
        resendStackView.isHidden = true
        resendButton.isHidden = false
    }
}

// MARK: - OTPValidityManagerDelegate

extension VerifyCodeScreen: OTPValidityManagerDelegate {
    func onTimerStarted() {
        doApplyTimerStartedLayout()
    }
    
    func onTimerFinished() {
        doApplyTimerFinishedLayout()
    }
    
    func onOTPLifetimeUpdated(_ remainingFormatted: String) {
        otpTimeLabel.text = remainingFormatted
    }
}

// MARK: - View Setup

extension VerifyCodeScreen {
    private func setupStrings() {
        self.navigationItem.title = .text.VerifyCode

        headerLabel.text = .text.VerifyCodeHeader
        sentToLabel.text = .text.VerifyCodeSentTo
        verifyButton.title = .text.Verify
        changePhoneNumberQuestionButton.title = .text.ChangePhoneNumberQuestion
    }

    private func setupDynamicLayout() {
        headerLabel.font = .avenirArabic_800(size: 16)
        sentToLabel.font = .avenirArabic_500(size: 12)
        phoneNumberLabel.font = .avenirArabic_500(size: 12)
        changePhoneNumberQuestionButton.titleLabel?.font = .avenirArabic_800(size: 14)
        otpTimeLabel.font = .avenirArabic_800(size: 12)
        resendButton.titleLabel?.font = .avenirArabic_800(size: 12)
        otpQuestionLabel.font = .avenirArabic_500(size: 12)

        sentToStackView.spacing = .dynamicToWidth(4)

        scrollContentBottomConstraint.constant = .dynamicToWidth(45)
        sentToTopConstraint.constant = .dynamicToWidth(16)
        sentToBottomConstraint.constant = .dynamicToWidth(0)
        otpStackTopConstraint.constant = .dynamicToWidth(48)
        otpStackBottomConstraint.constant = .dynamicToWidth(48)
        resendStackTopConstraint.constant = .dynamicToWidth(48)
    }
}
