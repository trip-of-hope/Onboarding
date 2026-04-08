import SwiftUI

// Splash is the NavigationStack root — only pushed destinations need a case.
enum AccountCreationStep: Hashable {
    case privacy
    case signupMethod
    case firstName
    case email
    case password
    case valueProp
    case goals
}

struct AccountCreationFlowView: View {
    @StateObject private var state = AccountCreationState()
    @State private var path: [AccountCreationStep] = []
    @State private var showPlanFlow = false

    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                SplashView(onGetStarted: { path.append(.privacy) })
                    .navigationDestination(for: AccountCreationStep.self) { step in
                        switch step {
                        case .privacy:
                            PrivacyConsentView(
                                state: state,
                                onContinue: { path.append(.signupMethod) }
                            )
                        case .signupMethod:
                            SignupMethodView(
                                onContinueWithEmail: { path.append(.firstName) }
                            )
                        case .firstName:
                            FirstNameInputView(
                                state: state,
                                onContinue: { path.append(.email) }
                            )
                        case .email:
                            EmailInputView(
                                state: state,
                                onContinue: { path.append(.password) }
                            )
                        case .password:
                            PasswordCreationView(
                                state: state,
                                onCreateAccount: { path.append(.valueProp) }
                            )
                        case .valueProp:
                            ValuePropFlowView(onComplete: { path.append(.goals) })
                        case .goals:
                            GoalsFlowView(
                                state: state,
                                onComplete: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        showPlanFlow = true
                                    }
                                }
                            )
                        }
                    }
            }
            .tint(.black)

            if showPlanFlow {
                PlanFlowView()
                    .transition(.opacity)
            }
        }
    }
}

// MARK: - Plan Flow Coordinator

private struct PlanFlowView: View {
    enum Stage { case loading, ready, offer }
    @State private var stage: Stage = .loading

    var body: some View {
        ZStack {
            switch stage {
            case .loading:
                PlanLoadingView {
                    withAnimation(.easeInOut(duration: 0.5)) { stage = .ready }
                }
                .transition(.opacity)
            case .ready:
                PlanReadyView {
                    withAnimation(.easeInOut(duration: 0.5)) { stage = .offer }
                }
                .transition(.opacity)
            case .offer:
                FreeTrialView(onStartNow: { /* hand off to main app */ })
                    .transition(.opacity)
            }
        }
        .background(Color.white)
    }
}

#Preview {
    AccountCreationFlowView()
}
