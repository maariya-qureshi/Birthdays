//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Maariya Qureshi on 7/11/25.
//

import SwiftUI
//importing SwiftData
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
                ContentView()
                    //adding in modelContainer
                    .modelContainer(for: Friend.self)
        }
    }
}
