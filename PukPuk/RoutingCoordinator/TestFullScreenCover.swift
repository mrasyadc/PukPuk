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
