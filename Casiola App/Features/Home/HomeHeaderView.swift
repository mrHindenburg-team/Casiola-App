import SwiftUI

struct HomeHeaderView: View {
    let greeting: String

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text(greeting)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.casiolaTextSecondary)

                Text("Casiola")
                    .font(.system(size: 28, weight: .light, design: .serif))
                    .foregroundStyle(Color.casiolaTextPrimary)
            }

            Spacer()

            // Avatar placeholder
            ZStack {
                Circle()
                    .fill(LinearGradient.goldRose)
                    .frame(width: 42, height: 42)

                Text("C")
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                    .foregroundStyle(Color.casiolaBackground)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}
