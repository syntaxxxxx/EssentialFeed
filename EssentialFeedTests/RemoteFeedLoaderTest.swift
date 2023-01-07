//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Fiqri Hafzain Islami on 30/12/22.
//

import Foundation
import XCTest
import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doestNotRequestDataFromURL(){
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_loadTwice_requestsDataFromURL(){
        let url = URL(string: "https://given-a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice(){
        let url = URL(string: "https://given-a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var message = [(url: URL, completion: (Error) -> Void)]()
    
        var requestedURLs: [URL] {
            return message.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            message.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            message[index].completion(error)
        }
    }
    
}
