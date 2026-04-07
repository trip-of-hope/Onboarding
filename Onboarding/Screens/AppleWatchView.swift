import SwiftUI

struct AppleWatchView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: 1, total: 6)
                .padding(.top, 8)

            Spacer().frame(height: 80)

            Text("Do you have an Apple Watch?")
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)

            Spacer().frame(height: 16)

            Text("Motra tracks exercises and repetitions automatically – no phone needed during your workout.")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black.opacity(0.6))
                .padding(.horizontal, 40)

            Spacer()

            VStack(spacing: 16) {
                Button(action: { state.hasAppleWatch = true }) {
                    Text("Yes")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(state.hasAppleWatch == true ? Color.white : Color.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(
                    state.hasAppleWatch == true ? Color.black : Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 20)
                )
                .buttonStyle(.plain)

                Button(action: { state.hasAppleWatch = false }) {
                    Text("No")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(state.hasAppleWatch == false ? Color.white : Color.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(
                    state.hasAppleWatch == false ? Color.black : Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 20)
                )
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)

            Spacer()

            PrimaryButton(title: "Continue", action: onContinue)
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
        AppleWatchView(state: AccountCreationState(), onContinue: {})
    }
}
