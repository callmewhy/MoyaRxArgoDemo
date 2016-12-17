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
import RxSwift
import Argo

private var disposeBag = DisposeBag()

class Demo5: XCTestCase {
    func test() {
        runAsynchronously(testCase: self) { finish in
            disposeBag = DisposeBag()
            let provider = RxMoyaProvider<API>()
            provider
                .request(API.showPost(id: 1))
                .subscribe { event in
                    switch event {
                    case .next(let response):
                        print(response)
                        finish()
                    case .error(let error):
                        print(error)
                    default:
                        break
                    }
                }
                .addDisposableTo(disposeBag)
        }
    }
}
