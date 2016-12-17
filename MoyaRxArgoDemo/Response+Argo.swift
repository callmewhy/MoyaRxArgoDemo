//
//  Response+Argo.swift
//  MoyaRxArgoDemo
//
//  Created by why on 16/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import Foundation
import Moya
import Argo

enum ORMError: Swift.Error {
    case ORMNoRepresentor
    case ORMNotSuccessfulHTTP
    case ORMNoData
    case ORMCouldNotMakeObjectError
}
extension Response {
    private func resultFromJSON<T: Decodable>(object:[String: AnyObject], classType: T.Type) -> T? {
        let decoded = classType.decode(JSON(object))
        switch decoded {
        case .success(let result):
            return result as? T
        case .failure(let error):
            print("\(error)")
            return nil
        }
    }
    
    func mapSuccessfulHTTPToObject<T: Decodable>(type: T.Type) throws -> T {
        guard ((200...209) ~= self.statusCode) else {
            if let json = try? JSONSerialization.jsonObject(with: self.data, options: .allowFragments) as? [String: AnyObject] {
                print("Got error message: \(json)")
            }
            throw ORMError.ORMNotSuccessfulHTTP
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: self.data, options: .allowFragments) as? [String: AnyObject] else {
                throw ORMError.ORMCouldNotMakeObjectError
            }
            return self.resultFromJSON(object: json, classType:type)!
        } catch {
            throw ORMError.ORMCouldNotMakeObjectError
        }
    }
}
