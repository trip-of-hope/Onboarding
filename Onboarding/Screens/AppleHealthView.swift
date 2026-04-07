import SwiftUI

struct AppleHealthView: View {
    let withWatch: Bool
    let progressStep: Int
    let onConnect: () -> Void
    @Environment(\.dismiss) private var dismiss

    private var description: String {
        withWatch
            ? "Motra needs your Health data to analyze your performance, recommend you activities and log your workouts with Apple Watch."
            : "Motra needs your Health data to analyze your performance and recommend you activities."
    }

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: progressStep, total: 6)
                .padding(.top, 8)

            Spacer()

            VStack(spacing: 32) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 40))
                    .opacity(0.2)

                Text("Allow access to Apple Health")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)

                Text(description)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 51)

            Spacer()

            PrimaryButton(title: "Connect to Apple Health", action: onConnect)
                .padding(.horizontal, 33)
                .padding(.bottom, 24)
        }
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
        AppleHealthView(withWatch: true, progressStep: 2, onConnect: {})
    }
}
