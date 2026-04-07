import SwiftUI

struct GoalSelectionView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    private let goals = [
        "Build strength",
        "Lose weight",
        "Build muscle",
        "Improve overall health",
        "Build a habit",
        "Other"
    ]

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: 4, total: 6)
                .padding(.top, 8)

            Spacer().frame(height: 80)

            Text("What's your goal?")
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer().frame(height: 16)

            Text("Choose a goal that you think suits you best.")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black.opacity(0.6))
                .padding(.horizontal, 40)

            Spacer().frame(height: 24)

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(goals, id: \.self) { goal in
                        OptionRow(
                            title: goal,
                            isSelected: state.goal == goal,
                            action: { state.goal = goal }
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
        GoalSelectionView(state: AccountCreationState(), onContinue: {})
    }
}
