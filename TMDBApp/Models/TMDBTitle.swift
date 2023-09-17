//
//  TMDBTitle.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 16/9/23.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [TMDBTitle]
}

struct TMDBTitle: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
