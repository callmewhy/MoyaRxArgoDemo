//
//  demo2.swift
//  MoyaRxArgoDemo
//
//  Created by why on 16/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import Foundation
import XCTest
@testable import MoyaRxArgoDemo
import Moya
import Argo

class Demo3: XCTestCase {
    func test() {
        runAsynchronously(testCase: self) { finish in
            let provider = MoyaProvider<API>()
            provider.request(API.showPost(id: 1)) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let json = try! JSONSerialization.jsonObject(with: data, options: [])
                    let post: Post = decode(json)!
                    print(post)
                    break
                case .failure(_):
                    break
                }
                finish()
            }
        }
    }
}
