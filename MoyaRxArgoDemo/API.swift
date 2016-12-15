//
//  APIswift.swift
//  MoyaRxArgoDemo
//
//  Created by why on 14/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import Foundation
import Moya

enum API {
    case zen
    case showUser(id: Int)
    case createUser(firstName: String, lastName: String)
    case showAccounts
}

// MARK: - TargetType Protocol Implementation
extension API: TargetType {
    var baseURL: URL { return URL(string: "https://api.myservice.com")! }
    var path: String {
        switch self {
        case .zen:
            return "/zen"
        case .showUser(let id):
            return "/users/\(id)"
        case .createUser(_, _):
            return "/users"
        case .showAccounts:
            return "/accounts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .zen, .showUser, .showAccounts:
            return .get
        case .createUser:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .zen, .showUser, .showAccounts:
            return nil
        case .createUser(let firstName, let lastName):
            return ["first_name": firstName, "last_name": lastName]
        }
    }
    var sampleData: Data {
        switch self {
        case .zen:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        case .showUser(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        case .createUser(let firstName, let lastName):
            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
        case .showAccounts:
            // Provided you have a file named accounts.json in your bundle.
            guard let path = Bundle.main.path(forResource: "accounts", ofType: "json"),
                let data = Data(base64Encoded: path) else {
                    return Data()
            }
            return data
        }
    }
    var task: Task {
        switch self {
        case .zen, .showUser, .createUser, .showAccounts:
            return .request
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
