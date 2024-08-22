//
//  ContentView.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
<<<<<<< HEAD
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
=======
        NavigationStack(path: $coordinator.path
        ) {
            coordinator.build(page: .record)
                .navigationDestination(for: Page.self) {
                    page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) {
                    sheet in coordinator.build(sheet: sheet)
                }

                .fullScreenCover(item: $coordinator.fullScreenCover) {
                    fullScreenCover in coordinator.build(fullScreenCover: fullScreenCover)
                }
>>>>>>> origin/development
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
