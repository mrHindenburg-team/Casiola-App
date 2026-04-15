import SwiftUI

// MARK: - Data

private struct DayStat: Identifiable {
    let id = UUID()
    let label: String
    let value: CGFloat // 0.0 – 1.0
}

// MARK: - View

struct StyleStatsCard: View {
    @Environment(ActivityManager.self) private var activityManager
 
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
 
            // Title row
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Your Style Week")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.casiolaTextPrimary)
                    Text("Outfits explored per day")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.casiolaTextSecondary)
                }
                Spacer()
 
                // Streak badge — hidden when streak is 0
                if activityManager.streakDays > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(Color(red: 1, green: 0.45, blue: 0.3))
                        Text("\(activityManager.streakDays)-day streak")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.casiolaTextPrimary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 1, green: 0.45, blue: 0.3).opacity(0.12))
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .strokeBorder(
                                Color(red: 1, green: 0.45, blue: 0.3).opacity(0.3),
                                lineWidth: 0.6
                            )
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.75), value: activityManager.streakDays)
 
            // Bar chart
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(activityManager.weeklyBarData, id: \.label) { entry in
                    DayBar(entry: entry)
                }
            }
            .frame(height: 72)
 
            // Stats row
            HStack(spacing: 0) {
                StatPill(
                    icon:  "heart.fill",
                    label: "Saved",
                    value: "\(activityManager.savedThisWeek)",
                    color: Color.casiolaGold
                )
                Divider()
                    .frame(height: 32)
                    .overlay(Color.casiolaStroke)
 
                StatPill(
                    icon:  "eye.fill",
                    label: "Viewed",
                    value: "\(activityManager.viewedThisWeek)",
                    color: Color(red: 0.45, green: 0.78, blue: 0.58)
                )
                Divider()
                    .frame(height: 32)
                    .overlay(Color.casiolaStroke)
 
                StatPill(
                    icon:  "sparkles",
                    label: "AI Tips",
                    value: "\(activityManager.aiChatsThisWeek)",
                    color: Color(red: 0.6, green: 0.5, blue: 1.0)
                )
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(Color.casiolaSurface)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.casiolaStroke, lineWidth: 0.5)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
 
// MARK: - Sub-views
 
private struct DayBar: View {
    let entry: ActivityManager.BarEntry
 
    var body: some View {
        VStack(spacing: 5) {
            GeometryReader { geo in
                VStack {
                    Spacer(minLength: 0)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            entry.isToday
                                ? AnyShapeStyle(LinearGradient.goldRose)
                                : AnyShapeStyle(
                                    LinearGradient(
                                        colors: [
                                            Color.casiolaGold.opacity(0.5),
                                            Color.casiolaGold.opacity(0.18)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )
                        .frame(height: max(6, geo.size.height * entry.value))
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: entry.value)
                }
            }
 
            Text(entry.label)
                .font(.system(size: 10, weight: entry.isToday ? .bold : .regular))
                .foregroundStyle(
                    entry.isToday ? Color.casiolaGold : Color.casiolaTextSecondary
                )
        }
        .frame(maxWidth: .infinity)
    }
}
 
private struct StatPill: View {
    let icon:  String
    let label: String
    let value: String
    let color: Color
 
    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 11))
                    .foregroundStyle(color)
                Text(value)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.casiolaTextPrimary)
                    .contentTransition(.numericText())
                    .animation(.spring(response: 0.4), value: value)
            }
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.casiolaTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}
