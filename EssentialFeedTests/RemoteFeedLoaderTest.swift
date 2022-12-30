//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Fiqri Hafzain Islami on 30/12/22.
//

import Foundation
import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doestNotRequestedDataFromURL(){
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
