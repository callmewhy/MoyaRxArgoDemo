//
//  API.swift
//  MoyaRxArgoDemo
//
//  Created by why on 15/12/2016.
//  Copyright © 2016 why. All rights reserved.
//  https://jsonplaceholder.typicode.com/

import XCTest
import Alamofire
@testable import MoyaRxArgoDemo


class API: XCTestCase {
    func testPerformanceExample() {
        let exp = expectation(description: "\(#function)\(#line)")
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/1").response { response in
            if let data = response.data {
                let str = String(data: data, encoding: String.Encoding.utf8)!
                print(str)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
    
}
