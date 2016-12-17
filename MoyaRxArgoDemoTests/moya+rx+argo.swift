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
                        let data = response.data
                        let json = try! JSONSerialization.jsonObject(with: data)
                        let post: Post = decode(json)!
                        print(post)
                    case .error(let error):
                        print(error)
                    case .completed:
                        finish()
                    }
                }
                .addDisposableTo(disposeBag)
        }
    }
}
