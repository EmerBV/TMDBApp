//
//  TMDBYoutubeSearchResponse.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 16/9/23.
//

import Foundation

struct TMDBYoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
