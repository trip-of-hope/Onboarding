import SwiftUI

struct PrivacyConsentView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Logo wordmark
            MotraWordmark()
                .padding(.top, 8)

            // Title + subtitle
            VStack(spacing: 16) {
                Text("We value your privacy.")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)

                Text("Your data is serious business.\nWe never share or sell your data with third parties.")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 40)
            .padding(.top, 48)

            Spacer()

            // Consent checkboxes
            VStack(spacing: 24) {
                CheckboxRow(isChecked: $state.privacyConsent1) {
                    Text("I understand that my data may be used to generate personalized insights and recommendations.")
                        .font(.system(size: 15, weight: .regular))
                        .fixedSize(horizontal: false, vertical: true)
                }

                CheckboxRow(isChecked: $state.privacyConsent2) {
                    Text("I agree to Motra's **Terms of Service** and **Privacy Policy.**")
                        .font(.system(size: 15))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 33)

            Spacer().frame(height: 32)

            // Buttons
            VStack(spacing: 12) {
                SecondaryButton(title: "Accept All") {
                    state.privacyConsent1 = true
                    state.privacyConsent2 = true
                }
                PrimaryButton(title: "Continue", action: onContinue)
                    .disabled(!(state.privacyConsent1 && state.privacyConsent2))
                    .opacity((state.privacyConsent1 && state.privacyConsent2) ? 1.0 : 0.35)
                    .animation(.easeInOut(duration: 0.2), value: state.privacyConsent1 && state.privacyConsent2)
            }
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
        PrivacyConsentView(state: AccountCreationState(), onContinue: {})
    }
}
