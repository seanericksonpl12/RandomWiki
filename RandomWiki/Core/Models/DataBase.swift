//
//  FavoritesData.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/4/22.
//

import SwiftUI

protocol DataBase {
    var articles: [Article] { get set }
}

struct TempDataBase: DataBase {
    var articles: [Article] = []
    // TODO: - Add whatever else I need in env
}

struct DataBaseKey: EnvironmentKey {
    static let defaultValue: DataBase = TempDataBase()
}

extension EnvironmentValues {
    var dataBase: DataBase {
        get { self[DataBaseKey.self] }
        set { self[DataBaseKey.self] = newValue }
    }
}
