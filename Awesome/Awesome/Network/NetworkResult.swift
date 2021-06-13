//
//  NetworkResult.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/13.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

