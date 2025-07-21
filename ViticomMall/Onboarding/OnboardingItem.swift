import SwiftUI

/// Modelo que representa cada pantalla del Onboarding
struct OnboardingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let color: Color
} 