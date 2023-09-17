//
//  Double.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 17/9/23.
//

import Foundation

extension Double {
    private var doubleFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toString() -> String {
        return doubleFormatter.string(for: self) ?? ""
    }
}
