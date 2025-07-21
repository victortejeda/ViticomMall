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

// --- Vista principal que decide qué mostrar: Onboarding, Login o App ---
struct ContentView: View {
    // Recuerda si el usuario ya completó el onboarding
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    // Recuerda si el usuario ya inició sesión
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        // Flujo de navegación principal
        if !hasCompletedOnboarding {
            // Si no ha completado el onboarding, mostrarlo
            OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
        } else if !isLoggedIn {
            // Si ya completó el onboarding pero no ha iniciado sesión, mostrar login
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            // Si ya inició sesión, mostrar la app principal
            MainAppView(isLoggedIn: $isLoggedIn)
        }
    }
}

// --- Contenedor del Onboarding Flow ---
struct OnboardingContainerView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var selectedTab = 0
    
    // Contenido de cada pantalla del onboarding
    private let onboardingItems: [OnboardingItem] = [
        .init(imageName: "sparkles", title: "¡Bienvenido a VitiMall!", description: "Tu destino para encontrar todo lo que necesitas, con un toque de magia.", color: .purple),
        .init(imageName: "tag.fill", title: "Ofertas que te Encantarán", description: "Activa las notificaciones para ser el primero en conocer descuentos exclusivos.", color: .orange),
        .init(imageName: "creditcard.fill", title: "Compra con Confianza", description: "Disfruta de un proceso de pago rápido, fácil y 100% seguro.", color: .blue),
        .init(imageName: "shippingbox.fill", title: "Recíbelo en tu Puerta", description: "Seguimiento en tiempo real para que sepas exactamente cuándo llegará tu pedido.", color: .green)
    ]

    var body: some View {
        ZStack {
            // Color de fondo dinámico según la pantalla
            onboardingItems[selectedTab].color.ignoresSafeArea()

            VStack {
                // TabView para las pantallas deslizables del onboarding
                TabView(selection: $selectedTab) {
                    ForEach(0..<onboardingItems.count, id: \.self) { index in
                        OnboardingScreenView(item: onboardingItems[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(.easeInOut(duration: 0.5), value: selectedTab)
                
                // Botón para finalizar el onboarding (solo en la última pantalla)
                if selectedTab == onboardingItems.count - 1 {
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0)) {
                            hasCompletedOnboarding = true
                        }
                    }) {
                        Text("¡Empezar!")
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
            // Imagen animada
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .rotationEffect(.degrees(isAnimating ? 0 : -10))
            
            VStack(spacing: 15) {
                // Título
                Text(item.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                // Descripción
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

// --- Vista de Login ---
struct LoginView: View {
    // Binding para actualizar el estado de login global
    @Binding var isLoggedIn: Bool
    // Estados locales para los campos de usuario y contraseña
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            // Título de la pantalla
            Text("Iniciar Sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)

            // Campo de usuario
            TextField("Usuario", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)

            // Campo de contraseña
            SecureField("Contraseña", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)

            // Mensaje de error si las credenciales son incorrectas
            if showError {
                Text("Usuario o contraseña incorrectos")
                    .foregroundColor(.red)
            }

            // Botón de acceso
            Button(action: {
                // Validación simple (usuario: admin, contraseña: 1234)
                if username == "admin" && password == "1234" {
                    isLoggedIn = true
                } else {
                    showError = true
                }
            }) {
                Text("Acceder")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .transition(.slide)
    }
}

// --- Vista principal de la aplicación ---
struct MainAppView: View {
    // Binding para permitir cerrar sesión
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationView {
            VStack {
                // Contenido principal (puedes reemplazarlo por tu lógica real)
                List {
                    Text("Producto 1")
                    Text("Producto 2")
                    Text("Producto 3")
                }
                // Botón para cerrar sesión
                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("Cerrar Sesión")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("VitiMall")
        }
    }
}

// --- Preview para ver el diseño en Xcode ---
#Preview {
    ContentView()
}
