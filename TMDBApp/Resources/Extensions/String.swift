//
//  String.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 16/9/23.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
