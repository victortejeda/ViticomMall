//
//  ContentView.swift
//  ViticomMall
//
//  Created by Victor Tejeda on 20/7/25.
//

import SwiftUI
import AuthenticationServices
// Importar vistas separadas
import OnboardingItem
import OnboardingContainerView
import OnboardingScreenView
import LoginView
import RegisterView
import MainAppView

/// Vista principal que decide qué mostrar: Onboarding, Login, Registro o App
struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var showRegister: Bool = false // Controla la navegación a registro

    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
        } else if !isLoggedIn && !showRegister {
            LoginView(isLoggedIn: $isLoggedIn, showRegister: $showRegister)
        } else if showRegister {
            RegisterView(showRegister: $showRegister)
        } else {
            MainAppView(isLoggedIn: $isLoggedIn)
        }
    }
}

// --- Preview para ver el diseño en Xcode ---
#Preview {
    ContentView()
}
