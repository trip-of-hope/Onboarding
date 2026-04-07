import SwiftUI

struct PasswordCreationView: View {
    @ObservedObject var state: AccountCreationState
    let onCreateAccount: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Text("Set a password")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .padding(.top, 32)

            RoundedSecureField(placeholder: "Password", text: $state.password)
                .padding(.horizontal, 20)
                .padding(.top, 24)

            Text("6 characters minimum.")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            Spacer()

            PrimaryButton(title: "Create Account", action: onCreateAccount)
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
        PasswordCreationView(state: AccountCreationState(), onCreateAccount: {})
    }
}
