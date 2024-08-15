//
//  ContentView.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 13/08/24.
//

import SwiftUI

class AddNoteWrapper: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var result: String?
}

struct ContentView: View {
    var body: some View {
//        NavigationStack {
//            <#code#>
//        }
        RecordPageViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
