//
//  ContentViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        @Published var savedAction: SimpleClosure = {}
        @Published var savedArticles: [URL] = []
    }
}
