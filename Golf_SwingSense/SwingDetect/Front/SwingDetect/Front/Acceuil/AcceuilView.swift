import SwiftUI

struct AcceuilView: View {
    @Binding var showView: Int

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TopView(width: geometry.size.width, height: geometry.size.height)
                MiddleView(showView: $showView, width: geometry.size.width, height: geometry.size.height)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

