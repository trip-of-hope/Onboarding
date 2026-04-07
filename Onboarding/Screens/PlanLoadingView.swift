import SwiftUI

struct PlanLoadingView: View {
    let onComplete: () -> Void

    @State private var showSecondMessage = false

    var body: some View {
        VStack(spacing: 32) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.3)
                .tint(.black)

            ZStack {
                Text("Getting ready your plan...")
                    .opacity(showSecondMessage ? 0 : 1)
                Text("Personalizing your experience...")
                    .opacity(showSecondMessage ? 1 : 0)
            }
            .font(.system(size: 21, weight: .semibold))
            .multilineTextAlignment(.center)
            .animation(.easeInOut(duration: 0.6), value: showSecondMessage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                showSecondMessage = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                onComplete()
            }
        }
    }
}

#Preview {
    PlanLoadingView(onComplete: {})
}
