import SwiftUI

struct BarrierSelectionView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    private let barriers = [
        "Lack of motivation",
        "Too busy / no time",
        "Not sure where to start",
        "Previous injuries",
        "Other"
    ]

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: 5, total: 6)
                .padding(.top, 8)

            Spacer().frame(height: 80)

            Text("What's held you back before?")
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)

            Spacer().frame(height: 16)

            Text("What is preventing you from achieving your goal?")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black.opacity(0.6))
                .padding(.horizontal, 40)

            Spacer().frame(height: 24)

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(barriers, id: \.self) { barrier in
                        OptionRow(
                            title: barrier,
                            isSelected: state.barrier == barrier,
                            action: { state.barrier = barrier }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }

            PrimaryButton(title: "Continue", action: onContinue)
                .padding(.horizontal, 33)
                .padding(.top, 16)
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
        BarrierSelectionView(state: AccountCreationState(), onContinue: {})
    }
}
