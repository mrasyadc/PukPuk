//
//  HomeView.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel

    // Use this to apply routing mechanism
    @EnvironmentObject var routingCoordinator: RoutingCoordinator

    var body: some View {
        ScrollView {
            // Iterate over the dictionary
            ForEach(vm.modelResult.sorted(by: <), id: \.key) { key, value in
                // Display key-value pair as "Key: Value"
                Text("\(key): \(value, specifier: "%.2f")")
            }

            // Use .push to show what page when button clicked
            Button(action: { routingCoordinator.push(page: .loading) }, label: {
                Text("Click to show example (loading)")
            })

            // Use .push to show what page when button clicked
            Button(action: { routingCoordinator.push(page: .record) }, label: {
                Text("Click to show example (record)")
            })

            Text(vm.errorText)

        }.refreshable {
            Task {
                await vm.checkAndGetModelResult()
            }
        }.onAppear {
            Task {
                await vm.checkAndGetModelResult()
            }
        }
        let _ = print(vm.$modelResult)
    }
}
