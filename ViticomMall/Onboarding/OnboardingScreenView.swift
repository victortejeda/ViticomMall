import SwiftUI

/// Vista para cada pantalla individual del Onboarding
struct OnboardingScreenView: View {
    let item: OnboardingItem
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .rotationEffect(.degrees(isAnimating ? 0 : -10))
            VStack(spacing: 15) {
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                Text(item.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 20)
            .offset(y: isAnimating ? 0 : 50)
            .opacity(isAnimating ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
                isAnimating = true
            }
        }
        .onDisappear {
            isAnimating = false
        }
    }
} 