import SwiftUI
import CoreData

/// Vista de Registro sencilla para crear una nueva cuenta
struct RegisterView: View {
    @Binding var showRegister: Bool
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Environment(\.managedObjectContext) private var viewContext
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
                        // Guardar usuario en Core Data
                        let newUser = User(context: viewContext)
                        newUser.username = username
                        newUser.email = email
                        newUser.password = password
                        do {
                            try viewContext.save()
                            showRegister = false // Regresa al login
                        } catch {
                            errorMessage = "Error al guardar usuario"
                            showError = true
                        }
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