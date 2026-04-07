import SwiftUI

// MARK: - Step enum

private enum GoalsStep: Hashable {
    case appleWatch
    case appleHealthWithWatch
    case watchAutoDetection
    case noWatchInfo
    case appleHealthWithoutWatch
    case goalSelection
    case barrierSelection
    case desiredWeight
    case personalizedMessage
    // New steps
    case trainingExperience
    case trainingSupportActivities
    case weeklySessions
    case experienceMessaging
    case trainingLocation
    case injurySelection
    case firstWorkoutFocus
    case workoutReminders
    case acquisitionSource
}

// MARK: - Container

struct GoalsFlowView: View {
    @ObservedObject var state: AccountCreationState
    let onComplete: () -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: GoalsStep = .appleWatch
    @State private var history: [GoalsStep] = []
    @State private var forward = true

    // MARK: Progress

    private var progressCurrent: Int {
        switch currentStep {
        case .appleWatch:                                      return 1
        case .appleHealthWithWatch, .noWatchInfo:              return 2
        case .watchAutoDetection, .appleHealthWithoutWatch:    return 3
        case .goalSelection:                                   return 4
        case .barrierSelection:                                return 5
        case .desiredWeight:                                   return 6
        case .personalizedMessage:                             return 7
        case .trainingExperience:                              return 8
        case .trainingSupportActivities:                       return 9
        case .weeklySessions:                                  return 10
        case .experienceMessaging:                             return 11
        case .trainingLocation:                                return 12
        case .injurySelection:                                 return 13
        case .firstWorkoutFocus:                               return 14
        case .workoutReminders:                                return 15
        case .acquisitionSource:                               return 16
        }
    }

    private var isCurrentStepValid: Bool {
        switch currentStep {
        case .appleWatch:                return state.hasAppleWatch != nil
        case .goalSelection:             return state.goal != nil
        case .barrierSelection:          return state.barrier != nil
        case .trainingExperience:        return state.trainingExperience != nil
        case .trainingSupportActivities: return !state.supportingActivities.isEmpty
        case .weeklySessions:            return state.weeklySessions != nil
        case .trainingLocation:          return state.trainingLocation != nil
        case .injurySelection:           return !state.injuries.isEmpty
        case .firstWorkoutFocus:         return state.workoutFocus != nil
        case .acquisitionSource:         return state.acquisitionSource != nil
        default:                         return true
        }
    }

    private var buttonTitle: String {
        switch currentStep {
        case .appleHealthWithWatch, .appleHealthWithoutWatch: return "Connect to Apple Health"
        case .personalizedMessage, .experienceMessaging:      return "Continue"
        case .workoutReminders:                               return "Enable Reminders"
        default:                                              return "Continue"
        }
    }

    // MARK: Body

    var body: some View {
        VStack(spacing: 0) {
            // ── Animated content ──
            ZStack {
                stepContent
                    .id(currentStep)
                    .transition(forward
                        ? .asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal:   .move(edge: .leading).combined(with: .opacity))
                        : .asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal:   .move(edge: .trailing).combined(with: .opacity))
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()

            // ── Fixed: button(s) ──
            if currentStep == .workoutReminders {
                VStack(spacing: 12) {
                    PrimaryButton(title: "Enable Reminders") {
                        state.reminderPermission = true
                        advance()
                    }
                    SecondaryButton(title: "Skip", action: advance)
                }
                .padding(.horizontal, 33)
                .padding(.bottom, 24)
            } else {
                PrimaryButton(title: buttonTitle, action: advance)
                    .disabled(!isCurrentStepValid)
                    .opacity(isCurrentStepValid ? 1.0 : 0.35)
                    .animation(.easeInOut(duration: 0.2), value: isCurrentStepValid)
                    .padding(.horizontal, 33)
                    .padding(.bottom, 24)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .medium))
                }
            }
            ToolbarItem(placement: .principal) {
                OnboardingProgressBar(current: progressCurrent, total: 16)
            }
        }
    }

    // MARK: Navigation

    private var nextStep: GoalsStep? {
        switch currentStep {
        case .appleWatch:
            return state.hasAppleWatch == true ? .appleHealthWithWatch : .noWatchInfo
        case .appleHealthWithWatch:       return .watchAutoDetection
        case .watchAutoDetection:         return .goalSelection
        case .noWatchInfo:                return .appleHealthWithoutWatch
        case .appleHealthWithoutWatch:    return .goalSelection
        case .goalSelection:              return .barrierSelection
        case .barrierSelection:
            return state.goal == "Lose weight" ? .desiredWeight : .personalizedMessage
        case .desiredWeight:              return .personalizedMessage
        case .personalizedMessage:        return .trainingExperience
        case .trainingExperience:         return .trainingSupportActivities
        case .trainingSupportActivities:  return .weeklySessions
        case .weeklySessions:             return .experienceMessaging
        case .experienceMessaging:        return .trainingLocation
        case .trainingLocation:           return .injurySelection
        case .injurySelection:            return .firstWorkoutFocus
        case .firstWorkoutFocus:          return .workoutReminders
        case .workoutReminders:           return .acquisitionSource
        case .acquisitionSource:          return nil
        }
    }

    private func advance() {
        guard let next = nextStep else { onComplete(); return }
        history.append(currentStep)
        withAnimation(.easeInOut(duration: 0.28)) {
            forward = true
            currentStep = next
        }
    }

    private func goBack() {
        if let prev = history.popLast() {
            withAnimation(.easeInOut(duration: 0.28)) {
                forward = false
                currentStep = prev
            }
        } else {
            dismiss()
        }
    }

    // MARK: Content router

    @ViewBuilder
    private var stepContent: some View {
        switch currentStep {
        case .appleWatch:
            appleWatchContent
        case .appleHealthWithWatch:
            appleHealthContent(withWatch: true)
        case .watchAutoDetection:
            infoCardContent(symbol: "applewatch",
                            text: "Auto-detection Messaging")
        case .noWatchInfo:
            infoCardContent(symbol: "applewatch",
                            text: "You get the best experience from Motra with Apple Watch.\n\nBut you can still use AI coaching and log your workouts manually.")
        case .appleHealthWithoutWatch:
            appleHealthContent(withWatch: false)
        case .goalSelection:
            singleSelectContent(
                title: "What's your goal?",
                subtitle: "Choose a goal that you think suits you best.",
                options: ["Build strength", "Lose weight", "Build muscle",
                          "Improve overall health", "Other"],
                selection: state.goal,
                onSelect: { state.goal = $0 }
            )
        case .barrierSelection:
            singleSelectContent(
                title: "What's held you back before?",
                subtitle: "What is preventing you from achieving your goal?",
                options: ["Lack of motivation", "Too busy / no time",
                          "Not sure where to start", "Previous injuries", "Other"],
                selection: state.barrier,
                onSelect: { state.barrier = $0 }
            )
        case .desiredWeight:
            desiredWeightContent
        case .personalizedMessage:
            infoCardContent(symbol: "figure.run",
                            text: "Messaging based on your goal and reason.")
        case .trainingExperience:
            singleSelectContent(
                title: "How much weight training experience do you have?",
                subtitle: nil,
                options: ["Just starting out", "1–2 years", "3–5 years", "5+ years"],
                selection: state.trainingExperience,
                onSelect: { state.trainingExperience = $0 }
            )
        case .trainingSupportActivities:
            multiSelectContent(
                title: "Is your training supporting anything else?",
                subtitle: nil,
                options: ["No, strength is my main focus",
                          "Running or endurance sports",
                          "Cycling",
                          "Team sports (football, basketball, etc.)",
                          "Another sport or activity"],
                selection: state.supportingActivities,
                exclusiveOption: "No, strength is my main focus",
                onToggle: toggleSupportingActivity
            )
        case .weeklySessions:
            singleSelectContent(
                title: "How many strength sessions a week are you aiming for?",
                subtitle: nil,
                options: ["1–2 sessions", "3 sessions", "4 sessions", "5+ sessions"],
                selection: state.weeklySessions,
                onSelect: { state.weeklySessions = $0 }
            )
        case .experienceMessaging:
            infoCardContent(symbol: "dumbbell.fill",
                            text: experienceMessagingText)
        case .trainingLocation:
            singleSelectContent(
                title: "Where do you prefer to train?",
                subtitle: nil,
                options: ["Full gym", "Home gym", "Minimal equipment", "Combination"],
                selection: state.trainingLocation,
                onSelect: { state.trainingLocation = $0 }
            )
        case .injurySelection:
            multiSelectContent(
                title: "Do you have any injuries?",
                subtitle: nil,
                options: ["No issues", "Back", "Knees", "Shoulders", "Other"],
                selection: state.injuries,
                exclusiveOption: "No issues",
                onToggle: toggleInjury
            )
        case .firstWorkoutFocus:
            singleSelectContent(
                title: "What would you like your first workout to focus on?",
                subtitle: nil,
                options: ["Upper Body", "Lower Body", "Full Body", "Core", "Not sure"],
                selection: state.workoutFocus,
                onSelect: { state.workoutFocus = $0 }
            )
        case .workoutReminders:
            permissionContent(
                symbol: "bell.fill",
                title: "Stay on top of your plan with workout reminders.",
                description: "Motra will send you timely reminders so you never miss a session. You can adjust or turn these off at any time in Settings."
            )
        case .acquisitionSource:
            singleSelectContent(
                title: "How did you hear about us?",
                subtitle: nil,
                options: ["Instagram", "TikTok", "App Store", "Facebook",
                          "YouTube", "Google Search", "Word of mouth", "Other"],
                selection: state.acquisitionSource,
                onSelect: { state.acquisitionSource = $0 }
            )
        }
    }
}

// MARK: - Content builders

private extension GoalsFlowView {

    // Apple Watch YES / NO
    var appleWatchContent: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)
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
                binaryButton("Yes",  selected: state.hasAppleWatch == true)  { state.hasAppleWatch = true }
                binaryButton("No",   selected: state.hasAppleWatch == false) { state.hasAppleWatch = false }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }

    func binaryButton(_ title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(selected ? Color.white : Color.black)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
        }
        .background(selected ? Color.black : Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 20))
        .buttonStyle(.plain)
    }

    // Apple Health permission
    func appleHealthContent(withWatch: Bool) -> some View {
        let description = withWatch
            ? "Motra needs your Health data to analyze your performance, recommend you activities and log your workouts with Apple Watch."
            : "Motra needs your Health data to analyze your performance and recommend you activities."
        return VStack(spacing: 0) {
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
        }
    }

    // Generic permission screen (Apple Health style)
    func permissionContent(symbol: String, title: String, description: String) -> some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 32) {
                Image(systemName: symbol)
                    .font(.system(size: 40))
                    .opacity(0.2)
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                Text(description)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 51)
            Spacer()
        }
    }

    // Info card
    func infoCardContent(symbol: String, text: String) -> some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 30) {
                Image(systemName: symbol)
                    .font(.system(size: 40))
                    .opacity(0.2)
                Text(text)
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
        }
    }

    // Single-select list
    func singleSelectContent(
        title: String,
        subtitle: String?,
        options: [String],
        selection: String?,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)
            if let subtitle {
                Spacer().frame(height: 16)
                Text(subtitle)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black.opacity(0.6))
                    .padding(.horizontal, 40)
            }
            if options.count == 2 {
                Spacer()
                VStack(spacing: 16) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(title: option, isSelected: selection == option,
                                  action: { onSelect(option) })
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            } else {
                Spacer().frame(height: 40)
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(options, id: \.self) { option in
                            OptionRow(title: option, isSelected: selection == option,
                                      action: { onSelect(option) })
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
        }
    }

    // Multi-select list
    func multiSelectContent(
        title: String,
        subtitle: String?,
        options: [String],
        selection: Set<String>,
        exclusiveOption: String,
        onToggle: @escaping (String) -> Void
    ) -> some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)
            if let subtitle {
                Spacer().frame(height: 16)
                Text(subtitle)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black.opacity(0.6))
                    .padding(.horizontal, 40)
            }
            if options.count == 2 {
                Spacer()
                VStack(spacing: 16) {
                    ForEach(options, id: \.self) { option in
                        OptionRow(
                            title: option,
                            isSelected: selection.contains(option),
                            action: { onToggle(option) }
                        )
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            } else {
                Spacer().frame(height: 40)
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(options, id: \.self) { option in
                            OptionRow(
                                title: option,
                                isSelected: selection.contains(option),
                                action: { onToggle(option) }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
        }
    }

    // Desired weight ruler
    var desiredWeightContent: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)
            Text("What's your desired weight?")
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)
            Spacer()
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text(String(format: "%.1f", state.desiredWeight))
                    .font(.system(size: 52, weight: .bold))
                    .contentTransition(.numericText())
                Text("kg")
                    .font(.system(size: 17))
                    .foregroundStyle(.secondary)
            }
            Spacer().frame(height: 32)
            WeightRulerView(weight: $state.desiredWeight)
                .frame(height: 80)
                .padding(.horizontal, 24)
            Spacer()
        }
    }

    // MARK: - Multi-select toggle logic

    func toggleSupportingActivity(_ option: String) {
        let exclusive = "No, strength is my main focus"
        if option == exclusive {
            state.supportingActivities = [exclusive]
        } else {
            state.supportingActivities.remove(exclusive)
            if state.supportingActivities.contains(option) {
                state.supportingActivities.remove(option)
            } else {
                state.supportingActivities.insert(option)
            }
        }
    }

    func toggleInjury(_ option: String) {
        let exclusive = "No issues"
        if option == exclusive {
            state.injuries = [exclusive]
        } else {
            state.injuries.remove(exclusive)
            if state.injuries.contains(option) {
                state.injuries.remove(option)
            } else {
                state.injuries.insert(option)
            }
        }
    }

    // MARK: - Dynamic messaging

    var experienceMessagingText: String {
        let level = state.trainingExperience ?? ""
        let crossTraining = !state.supportingActivities.isEmpty
            && !state.supportingActivities.isSubset(of: ["No, strength is my main focus"])

        switch level {
        case "Just starting out":
            return crossTraining
                ? "Your other activities will complement your strength training. We'll keep sessions efficient and manageable."
                : "Everyone starts somewhere. We'll build your foundation step by step, with sessions designed for progress."
        case "1–2 years":
            return crossTraining
                ? "A great base — we'll design sessions that fit around your other training without overloading you."
                : "You've got a solid foundation. We'll build on what you know and keep you progressing."
        case "3–5 years":
            return crossTraining
                ? "With your experience, we'll balance your strength work to complement everything else you're doing."
                : "Solid experience. We'll push performance further and keep things challenging."
        case "5+ years":
            return crossTraining
                ? "Impressive. We'll program sessions that fit your broader training demands and keep you performing at your best."
                : "With your background, we'll focus on what moves the needle — refined programming for experienced athletes."
        default:
            return "We'll build a plan tailored to your experience and goals."
        }
    }
}

// MARK: - Weight Ruler

private struct WeightRulerView: View {
    @Binding var weight: Double

    private let minWeight: Double = 30
    private let maxWeight: Double = 200
    private let pointsPerKg: CGFloat = 56

    @State private var dragStartWeight: Double = 70
    @State private var isDragging = false

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Canvas { context, size in
                    let centerX = size.width / 2
                    let visibleRange = Double(size.width / pointsPerKg) + 2
                    var v = (((weight - visibleRange / 2) * 10).rounded(.down)) / 10
                    let endV = weight + visibleRange / 2
                    while v <= endV {
                        let x = centerX + CGFloat(v - weight) * pointsPerKg
                        guard x >= -2 && x <= size.width + 2 else {
                            v = ((v * 10) + 1).rounded() / 10; continue
                        }
                        let rem = (v * 10).rounded().truncatingRemainder(dividingBy: 10)
                        let isWhole = abs(rem) < 0.5
                        let isHalf  = abs(abs(rem) - 5) < 0.5
                        let tickH: CGFloat = isWhole ? 36 : (isHalf ? 22 : 12)
                        let alpha: Double  = isWhole ? 0.35 : 0.18
                        var path = Path()
                        path.move(to:    CGPoint(x: x, y: size.height - tickH))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                        context.stroke(path, with: .color(.black.opacity(alpha)),
                                       lineWidth: isWhole ? 2 : 1)
                        if isWhole {
                            context.draw(
                                Text(String(Int(v.rounded())))
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.black.opacity(0.3)),
                                at: CGPoint(x: x, y: size.height - tickH - 14),
                                anchor: .center
                            )
                        }
                        v = ((v * 10) + 1).rounded() / 10
                    }
                }
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if !isDragging { isDragging = true; dragStartWeight = weight }
                    let delta = -Double(value.translation.width) / Double(pointsPerKg)
                    weight = ((dragStartWeight + delta) * 10).rounded() / 10
                    weight = min(max(weight, minWeight), maxWeight)
                }
                .onEnded { _ in isDragging = false }
        )
    }
}

#Preview {
    NavigationStack {
        GoalsFlowView(state: AccountCreationState(), onComplete: {})
    }
}
