import SwiftUI

struct DesiredWeightView: View {
    @ObservedObject var state: AccountCreationState
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(current: 5, total: 7)
                .padding(.top, 8)

            Spacer().frame(height: 80)

            Text("What's your desired weight?")
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 33)

            Spacer()

            // Weight display
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text(String(format: "%.1f", state.desiredWeight))
                    .font(.system(size: 52, weight: .bold))
                    .contentTransition(.numericText())
                Text("kg")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.secondary)
            }

            Spacer().frame(height: 32)

            // Ruler picker
            WeightRulerPicker(weight: $state.desiredWeight)
                .frame(height: 80)
                .padding(.horizontal, 24)

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

// MARK: - Weight Ruler Picker

private struct WeightRulerPicker: View {
    @Binding var weight: Double

    private let minWeight: Double = 30
    private let maxWeight: Double = 200
    private let pointsPerKg: CGFloat = 56

    @State private var dragStartWeight: Double = 70
    @State private var isDragging = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Tick marks canvas
                Canvas { context, size in
                    let centerX = size.width / 2
                    let visibleRange = Double(size.width / pointsPerKg) + 2

                    let startV = (((weight - visibleRange / 2) * 10).rounded(.down)) / 10
                    let endV   = weight + visibleRange / 2

                    var v = startV
                    while v <= endV {
                        let x = centerX + CGFloat(v - weight) * pointsPerKg
                        guard x >= -2 && x <= size.width + 2 else {
                            v = ((v * 10) + 1).rounded() / 10
                            continue
                        }

                        let remainder = (v * 10).rounded().truncatingRemainder(dividingBy: 10)
                        let isWhole = abs(remainder) < 0.5
                        let isHalf  = abs(abs(remainder) - 5) < 0.5

                        let tickH: CGFloat = isWhole ? 36 : (isHalf ? 22 : 12)
                        let tickW: CGFloat = isWhole ? 2 : 1
                        let alpha: Double  = isWhole ? 0.35 : 0.18

                        var path = Path()
                        path.move(to:    CGPoint(x: x, y: size.height - tickH))
                        path.addLine(to: CGPoint(x: x, y: size.height))
                        context.stroke(path, with: .color(.black.opacity(alpha)), lineWidth: tickW)

                        if isWhole {
                            let label = Text(String(Int(v.rounded())))
                                .font(.system(size: 12))
                                .foregroundStyle(Color.black.opacity(0.3))
                            context.draw(label,
                                         at: CGPoint(x: x, y: size.height - tickH - 14),
                                         anchor: .center)
                        }

                        v = ((v * 10) + 1).rounded() / 10
                    }
                }

                // Center indicator
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
                    if !isDragging {
                        isDragging = true
                        dragStartWeight = weight
                    }
                    let delta = -Double(value.translation.width) / Double(pointsPerKg)
                    let raw = dragStartWeight + delta
                    weight = ((raw * 10).rounded() / 10).clamped(to: minWeight...maxWeight)
                }
                .onEnded { _ in
                    isDragging = false
                }
        )
    }
}

private extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

#Preview {
    NavigationStack {
        DesiredWeightView(state: AccountCreationState(), onContinue: {})
    }
}
