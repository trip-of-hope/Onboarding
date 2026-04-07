import SwiftUI

private struct ValuePropStep {
    let symbolName: String
    let description: String
    let buttonTitle: String
}

struct ValuePropFlowView: View {
    let onComplete: () -> Void

    private let steps: [ValuePropStep] = [
        .init(symbolName: "figure.run",      description: "What Motra Does: Screen 1", buttonTitle: "Continue"),
        .init(symbolName: "figure.climbing", description: "What Motra Does: Screen 2", buttonTitle: "Continue"),
        .init(symbolName: "applewatch",      description: "What Motra Does: Screen 3", buttonTitle: "Continue"),
    ]

    @State private var currentStep = 0

    var body: some View {
        let step = steps[currentStep]

        VStack(spacing: 0) {
            Spacer().frame(height: 80)

            // Title
            Text("Welcome to Motra!")
                .font(.system(size: 24, weight: .semibold))

            Spacer()

            // Content card
            VStack(spacing: 30) {
                Image(systemName: step.symbolName)
                    .font(.system(size: 40))
                    .opacity(0.2)

                Text(step.description)
                    .font(.system(size: 17, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: 252)
            }
            .frame(width: 336, height: 448)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.12), radius: 40)

            Spacer()

            PrimaryButton(title: step.buttonTitle) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if currentStep < steps.count - 1 {
                        currentStep += 1
                    } else {
                        onComplete()
                    }
                }
            }
            .padding(.horizontal, 33)
            .padding(.bottom, 24)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}


#Preview {
    NavigationStack {
        ValuePropFlowView(onComplete: {})
    }
}
