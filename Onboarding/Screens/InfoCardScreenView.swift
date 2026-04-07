import SwiftUI

/// Reusable full-screen card layout used for info/messaging screens
/// (No-Watch info, Auto-detection messaging, Personalized message).
struct InfoCardScreenView: View {
    let symbolName: String
    let description: String
    let buttonTitle: String
    let progressStep: Int
    let progressTotal: Int
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: progressStep, total: progressTotal)
                .padding(.top, 8)

            Spacer()

            VStack(spacing: 30) {
                Image(systemName: symbolName)
                    .font(.system(size: 40))
                    .opacity(0.2)

                Text(description)
                    .font(.system(size: 17, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: 252)
            }
            .frame(width: 336)
            .padding(.vertical, 60)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.12), radius: 40)

            Spacer()

            PrimaryButton(title: buttonTitle, action: onContinue)
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
        InfoCardScreenView(
            symbolName: "applewatch",
            description: "Auto-detection Messaging",
            buttonTitle: "Continue",
            progressStep: 3,
            progressTotal: 6,
            onContinue: {}
        )
    }
}
