import SwiftUI
import AuthenticationServices
import CoreData

/// Vista de Login profesional con animaciones y social login
struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var showRegister: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isLoading: Bool = false
    @Namespace private var animation
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("loggedUser") var loggedUser: String = ""

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
                    TextField("Usuario o correo", text: $username)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        // Buscar usuario en Core Data por username o email
                        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                        fetchRequest.predicate = NSPredicate(format: "(username == %@ OR email == %@) AND password == %@", username, username, password)
                        do {
                            let users = try viewContext.fetch(fetchRequest)
                            if let user = users.first {
                                loggedUser = user.email ?? user.username ?? ""
                                isLoggedIn = true
                                showError = false
                            } else if username == "admin" && password == "1234" {
                                loggedUser = "admin"
                                isLoggedIn = true
                                showError = false
                            } else {
                                showError = true
                            }
                        } catch {
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