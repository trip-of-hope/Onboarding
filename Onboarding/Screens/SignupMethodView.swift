import SwiftUI

struct SignupMethodView: View {
    let onContinueWithEmail: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Logo + subtitle — 32pt gap between them
            VStack(spacing: 32) {
                MotraWordmark()
                Text("Let's get started.")
                    .font(.system(size: 24, weight: .medium))
            }
            .padding(.top, 8)

            Spacer()

            // Auth buttons
            VStack(spacing: 12) {
                AuthProviderButton(
                    title: "Continue with Apple",
                    icon: .system("apple.logo"),
                    style: .primary,
                    action: {}
                )

                AuthProviderButton(
                    title: "Continue with Google",
                    icon: .asset("google-logo"),
                    style: .secondary,
                    action: {}
                )
            }

            // 32pt gap between filled buttons and ghost button
            Spacer().frame(height: 32)

            Button(action: onContinueWithEmail) {
                Text("Continue with Email")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .opacity(0.4)
            }

            Spacer().frame(height: 24)
        }
        .padding(.horizontal, 33)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .medium))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignupMethodView(onContinueWithEmail: {})
    }
}
