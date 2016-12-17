//
//  Observable.swift
//  MoyaRxArgoDemo
//
//  Created by why on 17/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import RxSwift
import Argo
import Moya

public extension ObservableType {
    func mapObject<T: Decodable>(type: T.Type) -> Observable<T> {
        func resultFromJSON(object:[String: AnyObject], classType: T.Type) -> T? {
            return classType.decode(JSON(object)).value as! T?
        }
        return map { data in
            let json = data as! [String: AnyObject]
            return resultFromJSON(object: json, classType:type)!
        }
    }
}
