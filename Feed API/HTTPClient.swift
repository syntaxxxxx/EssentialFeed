//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Fiqri Hafzain Islami on 17/01/23.
//

import Foundation

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
