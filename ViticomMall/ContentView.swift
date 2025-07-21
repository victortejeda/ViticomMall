//
//  ContentView.swift
//  ViticomMall
//
//  Created by Victor Tejeda on 20/7/25.
//

import SwiftUI
import AuthenticationServices // Para el botón de Apple Sign-In

// --- Estructura para cada pantalla del Onboarding ---
struct OnboardingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let color: Color
}

// --- Vista principal que decide qué mostrar: Onboarding, Login, Registro o App ---
struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var showRegister: Bool = false // Controla la navegación a registro

    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingContainerView(hasCompletedOnboarding: $hasCompletedOnboarding)
        } else if !isLoggedIn && !showRegister {
            // Pantalla de login
            LoginView(isLoggedIn: $isLoggedIn, showRegister: $showRegister)
        } else if showRegister {
            // Pantalla de registro
            RegisterView(showRegister: $showRegister)
        } else {
            // App principal
            MainAppView(isLoggedIn: $isLoggedIn)
        }
    }
}

// --- Contenedor del Onboarding Flow ---
struct OnboardingContainerView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var selectedTab = 0
    private let onboardingItems: [OnboardingItem] = [
        .init(imageName: "sparkles", title: "¡Bienvenido a VitiMall!", description: "Tu destino para encontrar todo lo que necesitas, con un toque de magia.", color: .purple),
        .init(imageName: "tag.fill", title: "Ofertas que te Encantarán", description: "Activa las notificaciones para ser el primero en conocer descuentos exclusivos.", color: .orange),
        .init(imageName: "creditcard.fill", title: "Compra con Confianza", description: "Disfruta de un proceso de pago rápido, fácil y 100% seguro.", color: .blue),
        .init(imageName: "shippingbox.fill", title: "Recíbelo en tu Puerta", description: "Seguimiento en tiempo real para que sepas exactamente cuándo llegará tu pedido.", color: .green)
    ]
    var body: some View {
        ZStack {
            onboardingItems[selectedTab].color.ignoresSafeArea()
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(0..<onboardingItems.count, id: \.self) { index in
                        OnboardingScreenView(item: onboardingItems[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(.easeInOut(duration: 0.5), value: selectedTab)
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

// --- Vista de Login profesional con animaciones y social login ---
struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var showRegister: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isLoading: Bool = false
    @Namespace private var animation

    var body: some View {
        ZStack {
            // Fondo con gradiente animado
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .opacity(0.95)
            VStack(spacing: 30) {
                // Logo animado
                Image(systemName: "cart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.top, 40)
                    .scaleEffect(isLoading ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.5), value: isLoading)
                // Título
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .matchedGeometryEffect(id: "title", in: animation)
                // Campo de usuario
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    TextField("Usuario", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Campo de contraseña
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                    SecureField("Contraseña", text: $password)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Mensaje de error
                if showError {
                    Text("Usuario o contraseña incorrectos")
                        .foregroundColor(.red)
                        .transition(.opacity)
                }
                // Botón de acceso con animación de carga
                Button(action: {
                    withAnimation { isLoading = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if username == "admin" && password == "1234" {
                            isLoggedIn = true
                        } else {
                            showError = true
                        }
                        isLoading = false
                    }
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Text("Acceder")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
                .padding(.horizontal, 40)
                .disabled(isLoading)
                // Botón para crear cuenta
                Button(action: {
                    withAnimation { showRegister = true }
                }) {
                    Text("¿No tienes cuenta? Crear cuenta")
                        .foregroundColor(.white)
                        .underline()
                }
                // Separador visual
                HStack {
                    Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.3))
                    Text("o")
                        .foregroundColor(.white.opacity(0.7))
                    Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.3))
                }.padding(.horizontal, 40)
                // Botón de Google (solo visual)
                Button(action: {
                    // Aquí iría la lógica real de Google Sign-In
                }) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.red)
                        Text("Iniciar sesión con Google")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                // Botón de Apple (real con AuthenticationServices, pero aquí solo visual)
                SignInWithAppleButton(
                    onRequest: { _ in },
                    onCompletion: { _ in }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 45)
                .cornerRadius(15)
                .padding(.horizontal, 40)
                Spacer()
            }
        }
        .transition(.move(edge: .bottom))
    }
}

// --- Vista de Registro sencilla ---
struct RegisterView: View {
    @Binding var showRegister: Bool
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(0.95)
            VStack(spacing: 25) {
                // Título
                Text("Crear Cuenta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                // Campo usuario
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    TextField("Usuario", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Campo email
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.gray)
                    TextField("Correo electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Campo contraseña
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                    SecureField("Contraseña", text: $password)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Confirmar contraseña
                HStack {
                    Image(systemName: "lock.rotation")
                        .foregroundColor(.gray)
                    SecureField("Confirmar contraseña", text: $confirmPassword)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                // Mensaje de error
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .transition(.opacity)
                }
                // Botón de registro
                Button(action: {
                    // Validación simple
                    if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        errorMessage = "Todos los campos son obligatorios"
                        showError = true
                    } else if password != confirmPassword {
                        errorMessage = "Las contraseñas no coinciden"
                        showError = true
                    } else {
                        // Aquí iría la lógica real de registro
                        showRegister = false // Regresa al login
                    }
                }) {
                    Text("Crear cuenta")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
                .padding(.horizontal, 40)
                // Botón para volver al login
                Button(action: {
                    withAnimation { showRegister = false }
                }) {
                    Text("¿Ya tienes cuenta? Iniciar sesión")
                        .foregroundColor(.white)
                        .underline()
                }
                Spacer()
            }
        }
        .transition(.move(edge: .bottom))
    }
}

// --- Vista principal de la aplicación ---
struct MainAppView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Producto 1")
                    Text("Producto 2")
                    Text("Producto 3")
                }
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
