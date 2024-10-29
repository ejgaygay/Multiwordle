//
//  MultiwordleApp.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//

import SwiftUI

@main
struct MultiwordleApp: App {
    @StateObject var dm = DataModel()
    @StateObject var csManager = ColorSchemeManager()
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
