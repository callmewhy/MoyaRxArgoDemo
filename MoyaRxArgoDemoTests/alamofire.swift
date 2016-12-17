//
//  API.swift
//  MoyaRxArgoDemo
//
//  Created by why on 15/12/2016.
//  Copyright © 2016 why. All rights reserved.
//  https://jsonplaceholder.typicode.com/

import XCTest
import Alamofire

class Demo: XCTestCase {
    func test() {
        runAsynchronously(testCase: self) { finish in
            Alamofire.request("https://jsonplaceholder.typicode.com/posts/1").response { response in
                print(response.data!)
                finish()
            }
        }
    }
}
