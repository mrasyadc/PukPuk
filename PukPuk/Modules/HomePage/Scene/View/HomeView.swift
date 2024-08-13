//
//  HomeView.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel

    var body: some View {
        ScrollView {
            // Iterate over the dictionary
            ForEach(vm.modelResult.sorted(by: <), id: \.key) { key, value in
                // Display key-value pair as "Key: Value"
                Text("\(key): \(value, specifier: "%.2f")")
            }

        }.refreshable {
            vm.refreshPage()
        }.onAppear {
            vm.checkAndGetModelResult()
        }
        let _ = print(vm.$modelResult)
    }
}

#Preview {
    HomeView()
}
