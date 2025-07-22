import SwiftUI

/// Vista principal de la aplicación después de iniciar sesión
struct MainAppView: View {
    @Binding var isLoggedIn: Bool
    @AppStorage("loggedUser") var loggedUser: String = ""
    var body: some View {
        NavigationView {
            VStack {
                // Mostrar el usuario logueado
                if !loggedUser.isEmpty {
                    Text("Bienvenido, \(loggedUser)")
                        .font(.headline)
                        .padding(.top, 20)
                }
                List {
                    Text("Producto 1")
                    Text("Producto 2")
                    Text("Producto 3")
                }
                Button(action: {
                    isLoggedIn = false
                    loggedUser = ""
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