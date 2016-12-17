//
//  Post.swift
//  MoyaRxArgoDemo
//
//  Created by why on 16/12/2016.
//  Copyright © 2016 why. All rights reserved.
//

import Foundation

import Argo
import Curry
import Runes

struct Post {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

extension Post: Decodable {
    public static func decode(_ j: JSON) -> Decoded<Post> {
        return curry(Post.init)
            <^> j <| "id"
            <*> j <| "userId"
            <*> j <| "title"
            <*> j <| "body"
    }
}
