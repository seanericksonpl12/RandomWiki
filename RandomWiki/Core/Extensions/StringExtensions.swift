//
//  StringExtensions.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import Foundation

extension String {
    var localized: String { String(localized: LocalizationValue(stringLiteral: self)) }
}
