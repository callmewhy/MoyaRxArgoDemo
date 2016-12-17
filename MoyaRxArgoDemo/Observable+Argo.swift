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

extension Observable {
    func mapSuccessfulHTTPToObject<T: Decodable>(type: T.Type) -> Observable<T> {
        func resultFromJSON(object:[String: AnyObject], classType: T.Type) -> T? {
            return classType.decode(JSON(object)).value as! T?
        }
        return map { representor in
            guard let response = representor as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            guard ((200...209) ~= response.statusCode) else {
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject] {
                    print("Got error message: \(json)")
                }
                throw ORMError.ORMNotSuccessfulHTTP
            }
            do {
                guard let json = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: AnyObject] else {
                    throw ORMError.ORMCouldNotMakeObjectError
                }
                return resultFromJSON(object: json!, classType:type)!
            } catch {
                throw ORMError.ORMCouldNotMakeObjectError
            }
        }
    }
}
