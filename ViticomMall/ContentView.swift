//
//  ContentView.swift
//  ViticomMall
//
//  Created by Victor Tejeda on 20/7/25.
//

import SwiftUI

// --- Estructura para cada pantalla del Onboarding ---
struct OnboardingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let color: Color
}

// --- Vista principal que decide si mostrar Onboarding o la App ---
struct ContentView: View {
    // Usamos @AppStorage para recordar si el usuario ya vio el onboarding
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some View {
        // Si el onboarding ya se completó, muestra la app principal
        // Si no, muestra el onboarding
        if hasCompletedOnboarding {
            MainAppView()
        } else {
            OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}

// --- Contenedor del Onboarding Flow ---
struct OnboardingContainerView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var selectedTab = 0
    
    // --- Define aquí el contenido de cada pantalla ---
    private let onboardingItems: [OnboardingItem] = [
        .init(imageName: "sparkles", title: "¡Bienvenido a VitiMall!", description: "Tu destino para encontrar todo lo que necesitas, con un toque de magia.", color: .purple),
        .init(imageName: "tag.fill", title: "Ofertas que te Encantarán", description: "Activa las notificaciones para ser el primero en conocer descuentos exclusivos.", color: .orange),
        .init(imageName: "creditcard.fill", title: "Compra con Confianza", description: "Disfruta de un proceso de pago rápido, fácil y 100% seguro.", color: .blue),
        .init(imageName: "shippingbox.fill", title: "Recíbelo en tu Puerta", description: "Seguimiento en tiempo real para que sepas exactamente cuándo llegará tu pedido.", color: .green)
    ]

    var body: some View {
        ZStack {
            // Color de fondo que cambia con cada pantalla
            onboardingItems[selectedTab].color.ignoresSafeArea()

            VStack {
                // --- TabView para las pantallas deslizables ---
                TabView(selection: $selectedTab) {
                    ForEach(0..<onboardingItems.count, id: \.self) { index in
                        OnboardingScreenView(item: onboardingItems[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(.easeInOut(duration: 0.5), value: selectedTab)
                
                // --- Botón para finalizar ---
                // Aparece solo en la última pantalla
                if selectedTab == onboardingItems.count - 1 {
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
                            hasCompletedOnboarding = true
                        }
                    }) {
                        Text("¡Empezar a Comprar!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .transition(.slide)
    }
}

// --- Vista para cada pantalla individual del Onboarding ---
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
                // Animación de escala
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                // Animación de rotación
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
            // Animación de entrada
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

// --- Vista principal de tu aplicación (ejemplo) ---
struct MainAppView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Producto 1")
                Text("Producto 2")
                Text("Producto 3")
            }
            .navigationTitle("VitiMall")
        }
    }
}

// --- Preview para ver el diseño en Xcode ---
#Preview {
    ContentView()
}
