import SwiftUI

struct SplashView: View {
    let onGetStarted: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Logo sits in the upper ~40% of the screen
            Spacer()
            MotraLogoView()
            Spacer()
            Spacer() // extra weight to push logo toward upper third

            // Bottom content block
            VStack(spacing: 0) {
                Text("AI coaching for the real world.")
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 33)

                Spacer().frame(height: 28)

                PrimaryButton(title: "Get Started", action: onGetStarted)
                    .padding(.horizontal, 33)

                Spacer().frame(height: 32)

                Button(action: {}) {
                    (Text("Already have an account? ")
                        .fontWeight(.regular) +
                     Text("Log in")
                        .fontWeight(.semibold))
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                }
            }

            Spacer().frame(height: 24)
        }
        .background(Color.white)
    }
}

#Preview {
    SplashView(onGetStarted: {})
}
