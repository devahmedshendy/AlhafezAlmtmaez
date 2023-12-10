//
//  OTPValidityManager.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 08/12/2023.
//

import UIKit

protocol OTPValidityManagerDelegate: AnyObject {
    func onTimerStarted()
    func onTimerFinished()
    func onOTPLifetimeUpdated(_ remainingFormatted: String)
}

final class OTPValidityManager {

    // MARK: - Properties

    weak var delegate: OTPValidityManagerDelegate?

    private var timer: Timer?

    let defaultLifetime: TimeInterval

    private(set) var lifetime: TimeInterval
    var lifetimeFormatted: String {
        return lifetimeFormatter.string(from: lifetime) ?? ""
    }
    private lazy var lifetimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.calendar?.locale = .current
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()

    // MARK: - LifeCycle

    init(lifetimeInSeconds: TimeInterval = 180) {
        self.defaultLifetime = lifetimeInSeconds
        self.lifetime = lifetimeInSeconds
    }

    deinit {
        timer?.invalidate()
        print(Self.self)
    }

    // MARK: - Logic

    func start() {
        delegate?.onTimerStarted()
        delegate?.onOTPLifetimeUpdated(lifetimeFormatted)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return  }

            self.lifetime -= 1
            self.delegate?.onOTPLifetimeUpdated(self.lifetimeFormatted)

            if self.lifetime == 0 {
                self.end()
            }
        }
    }

    func end() {
        timer?.invalidate()
        timer = nil
        delegate?.onTimerFinished()
    }

    func restart(){
        lifetime = defaultLifetime
        start()
    }
}
