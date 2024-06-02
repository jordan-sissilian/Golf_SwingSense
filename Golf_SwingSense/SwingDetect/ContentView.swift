import SwiftUI

struct ContentView: View {
    @State private var showView: Int = 1

    var body: some View {
        VStack() {
            if showView == 1 {
                AcceuilView(showView: $showView)
            } else if showView == 2 {
                SwingView(showView: $showView)
            } else if showView == 3 {
                test()
            }
        }
        
    }
}

