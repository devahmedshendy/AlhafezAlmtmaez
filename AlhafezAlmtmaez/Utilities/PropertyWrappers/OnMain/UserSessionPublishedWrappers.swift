//
//  PublishedUserSessionStateOnMain.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation
import Combine

@propertyWrapper
final class PublishedUserSessionStateOnMain {

    private lazy var session: UserSession = .shared

    var wrappedValue: UserSession.State {
        get {
            session.state
        }
    }

    var projectedValue: AnyPublisher<UserSession.State, Never> {
        get {
            session.$state
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
