//
//  Fullscreen1.swift
//  DeafHealth
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/08/24.
//

import SwiftUI

struct TestFullScreenCover: View {
    @EnvironmentObject var coordinator: RoutingCoordinator
    var body: some View {
        Button(action: { coordinator.dismissFullScreenCover() }) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    TestFullScreenCover()
}
