//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Fiqri Hafzain Islami on 08/12/22.
//

import Foundation

public struct FeedItem: Equatable{
    let id: UUID
    let description: String?
    let location: String?
    let imageUrl: URL
}
