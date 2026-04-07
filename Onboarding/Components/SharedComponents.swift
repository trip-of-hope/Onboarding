import SwiftUI

// MARK: - Primary Button (black Liquid Glass)

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .buttonStyle(.plain)
        .background(.black, in: Capsule())
    }
}

// MARK: - Secondary Button (light Liquid Glass)

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .tint(.black)
        .glassEffect(in: Capsule())
    }
}

// MARK: - Auth Provider Button

struct AuthProviderButton: View {
    enum Style { case primary, secondary }

    enum Icon {
        case system(String)   // SF Symbol
        case asset(String)    // Assets.xcassets image name
        case none
    }

    let title: String
    let icon: Icon
    let style: Style
    let action: () -> Void

    init(title: String, icon: Icon = .none, style: Style = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .system(let name):
            Image(systemName: name)
                .font(.system(size: 17, weight: .medium))
        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        case .none:
            EmptyView()
        }
    }

    var body: some View {
        if style == .primary {
            Button(action: action) {
                HStack(spacing: 8) {
                    iconView
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
            }
            .buttonStyle(.plain)
            .background(.black, in: Capsule())
        } else {
            Button(action: action) {
                HStack(spacing: 8) {
                    iconView
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
            }
            .tint(.black)
            .glassEffect(in: Capsule())
        }
    }
}

// MARK: - Rounded Input Field

struct RoundedInputField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 17, weight: .medium))
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Rounded Secure Field (with eye toggle)

struct RoundedSecureField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isVisible = false

    var body: some View {
        HStack {
            Group {
                if isVisible {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(.system(size: 17, weight: .medium))

            Button(action: { isVisible.toggle() }) {
                Image(systemName: isVisible ? "eye" : "eye.slash")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 56)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Checkbox Row

struct CheckboxRow<Label: View>: View {
    @Binding var isChecked: Bool
    @ViewBuilder let label: () -> Label

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 14) {
            Button(action: { isChecked.toggle() }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isChecked ? Color.black : Color(.secondarySystemBackground))
                        .frame(width: 24, height: 24)
                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .buttonStyle(.plain)
            // Align the checkbox's vertical center to the text's first baseline
            .alignmentGuide(.firstTextBaseline) { d in d[VerticalAlignment.center] }
            label()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Onboarding Progress Bar

struct OnboardingProgressBar: View {
    let current: Int
    let total: Int

    private let trackWidth: CGFloat = 182
    private let height: CGFloat = 6

    var fillWidth: CGFloat {
        trackWidth * CGFloat(current) / CGFloat(total)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color(white: 120.0 / 255.0).opacity(0.2))
                .frame(width: trackWidth, height: height)
            Capsule()
                .fill(Color.black)
                .frame(width: fillWidth, height: height)
        }
    }
}

// MARK: - Option Row (single-select list item)

struct OptionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.black : Color.white)
                        .frame(width: 24, height: 24)
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            .frame(height: 64)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1.5)
                    .opacity(isSelected ? 1 : 0)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Motra Logo

/// Wordmark (logo-name.svg) used on Privacy, Sign Up, Email, and Password screens.
struct MotraWordmark: View {
    var body: some View {
        Image("logo-name")
            .resizable()
            .scaledToFit()
            .frame(height: 20)
    }
}

/// Full logo (logo-full.svg) used on the Splash screen.
struct MotraLogoView: View {
    var body: some View {
        Image("logo-full")
            .resizable()
            .scaledToFit()
            .frame(width: 160)
    }
}
