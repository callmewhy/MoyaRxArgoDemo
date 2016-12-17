//
//  run.swift
//  MoyaRxArgoDemo
//
//  Created by why on 16/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import XCTest

func runAsynchronously(testCase: XCTestCase, closure: (@escaping () -> ()) -> ()) {
    let exp = testCase.expectation(description: "\(#function)\(#line)")
    let finish = exp.fulfill
    closure(finish)
    testCase.waitForExpectations(timeout: 10, handler: nil)
}
