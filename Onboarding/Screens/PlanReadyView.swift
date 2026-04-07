import SwiftUI

// MARK: - Data

private struct Exercise {
    let name: String
    let detail: String
}

private struct DayPlan {
    let label: String
    let exercises: [Exercise]
}

private let weekPlan: [DayPlan] = [
    DayPlan(label: "Day 1:", exercises: [
        Exercise(name: "Barbell Bench Press",         detail: "3 x 10 Reps  •  45–55 Lbs"),
        Exercise(name: "Dumbbell Incline Bicep Curl", detail: "3 x 10 Reps  •  15–20 Lbs"),
        Exercise(name: "Bicycle Crunch",              detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Tricep Kickback",    detail: "3 x 10 Reps  •  10–20 Lbs"),
        Exercise(name: "ATG Split Squat",             detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Fly",                detail: "3 x 10 Reps  •  10–20 Lbs"),
    ]),
    DayPlan(label: "Day 2:", exercises: [
        Exercise(name: "Barbell Bench Press",         detail: "3 x 10 Reps  •  45–55 Lbs"),
        Exercise(name: "Dumbbell Incline Bicep Curl", detail: "3 x 10 Reps  •  15–20 Lbs"),
        Exercise(name: "Bicycle Crunch",              detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Tricep Kickback",    detail: "3 x 10 Reps  •  10–20 Lbs"),
        Exercise(name: "ATG Split Squat",             detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Fly",                detail: "3 x 10 Reps  •  10–20 Lbs"),
    ]),
    DayPlan(label: "Day 3:", exercises: [
        Exercise(name: "Barbell Bench Press",         detail: "3 x 10 Reps  •  45–55 Lbs"),
        Exercise(name: "Dumbbell Incline Bicep Curl", detail: "3 x 10 Reps  •  15–20 Lbs"),
        Exercise(name: "Bicycle Crunch",              detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Tricep Kickback",    detail: "3 x 10 Reps  •  10–20 Lbs"),
        Exercise(name: "ATG Split Squat",             detail: "3 x 10 Reps"),
        Exercise(name: "Dumbbell Fly",                detail: "3 x 10 Reps  •  10–20 Lbs"),
    ]),
]

private let weekDays: [(label: String, day: String?, isWorkout: Bool)] = [
    ("TODAY", nil,  true),
    ("MON",   "8",  false),
    ("TUE",   "9",  false),
    ("WED",   "10", true),
    ("THU",   "11", false),
    ("FRI",   "12", true),
    ("SAT",   "13", false),
]

// MARK: - Main View

struct PlanReadyView: View {
    let onComplete: () -> Void

    @State private var appeared = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title + subtitle
                    VStack(alignment: .center, spacing: 12) {
                        Text("Your first week of workouts is ready!")
                            .font(.system(size: 24, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .tracking(-0.5)

                        Text("Motra Coach can adjust your workout based on your feedback.")
                            .font(.system(size: 17))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black.opacity(0.6))
                            .padding(.horizontal, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 33)
                    .padding(.top, 72)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(.easeOut(duration: 0.4), value: appeared)

                    // Week strip
                    WeekStripView(days: weekDays)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 16)
                        .animation(.easeOut(duration: 0.4).delay(0.15), value: appeared)

                    // Day sections
                    ForEach(Array(weekPlan.enumerated()), id: \.offset) { index, day in
                        DaySectionView(plan: day)
                            .padding(.horizontal, 20)
                            .padding(.top, 28)
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : 16)
                            .animation(
                                .easeOut(duration: 0.4).delay(0.3 + Double(index) * 0.15),
                                value: appeared
                            )
                    }

                    Spacer().frame(height: 96)
                }
            }

            // Fixed Start Now button
            PrimaryButton(title: "Start Now", action: onComplete)
                .padding(.horizontal, 33)
                .padding(.bottom, 24)
                .background(
                    LinearGradient(
                        colors: [.white.opacity(0), .white, .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .opacity(appeared ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.75), value: appeared)
        }
        .background(Color.white)
        .onAppear {
            DispatchQueue.main.async { appeared = true }
        }
    }
}

// MARK: - Week Strip

private struct WeekStripView: View {
    let days: [(label: String, day: String?, isWorkout: Bool)]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.label) { item in
                WeekDayCell(label: item.label, day: item.day, isWorkout: item.isWorkout)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 116/255, green: 116/255, blue: 128/255).opacity(0.06))
        )
    }
}

private struct WeekDayCell: View {
    let label: String
    let day: String?
    let isWorkout: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isWorkout ? Color.black : Color(red: 116/255, green: 116/255, blue: 128/255).opacity(0.08))
                    .frame(width: 36, height: 36)

                if isWorkout {
                    Image(systemName: "dumbbell.fill")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white)
                } else if let day {
                    Text(day)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
            }

            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(isWorkout ? Color.primary : Color(.tertiaryLabel))
                .tracking(0.5)
        }
    }
}

// MARK: - Day Section

private struct DaySectionView: View {
    let plan: DayPlan

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(plan.label)
                .font(.system(size: 20, weight: .semibold))
                .tracking(-0.45)

            VStack(spacing: 8) {
                ForEach(plan.exercises, id: \.name) { exercise in
                    ExerciseCardView(exercise: exercise)
                }
            }
        }
    }
}

// MARK: - Exercise Card

private struct ExerciseCardView: View {
    let exercise: Exercise

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(.tertiaryLabel))
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(exercise.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)
                    .tracking(-0.4)
                Text(exercise.detail)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .tracking(-0.25)
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 116/255, green: 116/255, blue: 128/255).opacity(0.04))
        )
    }
}

#Preview {
    PlanReadyView(onComplete: {})
}
