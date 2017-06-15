//
//  SessionManager.swift
//  MimoiOSCodingChallenge
//
//  Created by Priyank on 16/06/2017.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation
import SimpleKeychain
import Auth0

enum SessionManagerError: Error {
    case noAccessToken
    case noIdToken
    case noIdentities
}

class SessionManager {
    static let shared = SessionManager()
    let keychain = A0SimpleKeychain(service: "Auth0")
    
    var idToken: String? {
        return self.keychain.string(forKey: "id_token")
    }
    var profile: Profile?
    
    private init () { }
    
    func storeTokens(_ accessToken: String, idToken: String) {
        self.keychain.setString(accessToken, forKey: "access_token")
        self.keychain.setString(idToken, forKey: "id_token")
    }
    
    func retrieveProfile(_ callback: @escaping (Error?) -> ()) {
        guard let accessToken = self.keychain.string(forKey: "access_token") else {
            return callback(SessionManagerError.noAccessToken)
        }
        Auth0.authentication()
            .userInfo(token: accessToken)
            .start { result in
                switch(result) {
                case .success(let profile):
                    self.profile = profile
                    callback(nil)
                case .failure(let error):
                    callback(error)
                }
        }
    }
    
    
    func retrieveIdentity(_ callback: @escaping (Error?, [Identity]?) -> ()) {
        guard let idToken = self.keychain.string(forKey: "id_token") else {
            return callback(SessionManagerError.noIdToken, nil)
        }
        guard let userId = profile?.id else {
            return callback(SessionManagerError.noIdToken, nil)
        }
        Auth0
            .users(token: idToken)
            .get(userId, fields: ["identities"], include: true)
            .start { result in
                switch result {
                case .success(let user):
                    let identityValues = user["identities"] as? [[String: Any]] ?? []
                    let identities = identityValues.flatMap { Identity(json: $0) }
                    callback(nil, identities)
                    break
                case .failure(let error):
                    callback(error, nil)
                    break
                }
        }
    }
    
    func logout() {
        self.keychain.clearAll()
    }
    
}
