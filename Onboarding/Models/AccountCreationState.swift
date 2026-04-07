import Foundation
import Combine

class AccountCreationState: ObservableObject {
    @Published var firstName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var privacyConsent1: Bool = false
    @Published var privacyConsent2: Bool = false
    @Published var hasAppleWatch: Bool? = nil
    @Published var goal: String? = nil
    @Published var desiredWeight: Double = 70.0
    @Published var barrier: String? = nil
    @Published var trainingExperience: String? = nil
    @Published var supportingActivities: Set<String> = []
    @Published var weeklySessions: String? = nil
    @Published var trainingLocation: String? = nil
    @Published var injuries: Set<String> = []
    @Published var workoutFocus: String? = nil
    @Published var acquisitionSource: String? = nil
    @Published var reminderPermission: Bool = false
}
