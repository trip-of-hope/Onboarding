import SwiftUI

struct FirstNameInputView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Text("What's your first name?")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .padding(.top, 32)

            RoundedInputField(
                placeholder: "First name",
                text: $state.firstName
            )
            .padding(.horizontal, 20)
            .padding(.top, 24)

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
        FirstNameInputView(state: AccountCreationState(), onContinue: {})
    }
}
