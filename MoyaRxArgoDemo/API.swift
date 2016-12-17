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
    case showPost(id: Int)
}

// MARK: - TargetType Protocol Implementation
extension API: TargetType {

    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    var path: String {
        switch self {
        case .showPost(let id):
            return "/posts/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showPost:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .showPost:
            return nil
        }
    }
    var sampleData: Data {
        switch self {
        case .showPost:
            return "".data(using: .utf8)!
        }
    }
    var task: Task {
        switch self {
        case .showPost(id: _):
            return .request
        }
    }
}
