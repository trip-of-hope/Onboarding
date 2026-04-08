import SwiftUI

struct FreeTrialView: View {
    let onStartNow: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Logo — upper portion of screen
            Spacer().frame(height: 72)
            MotraLogoView()

            Spacer()

            // Main copy — vertically centered
            VStack(spacing: 20) {
                Text("Building a habit takes time. That's why your first 10 workouts are free.")
                    .font(.system(size: 40, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .tracking(-0.5)

                Text("No commitment. No credit card required.")
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black.opacity(0.6))
                    .frame(width: 285)
            }
            .padding(.horizontal, 25)

            Spacer()

            // Buttons
            VStack(spacing: 12) {
                SecondaryButton(title: "See our Plan Options", action: {})
                PrimaryButton(title: "Start Now", action: onStartNow)
            }
            .padding(.horizontal, 33)
            .padding(.bottom, 24)
        }
        .background(Color.white)
    }
}

#Preview {
    FreeTrialView(onStartNow: {})
}
