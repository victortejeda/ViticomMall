import SwiftUI

/// Vista principal de la aplicación después de iniciar sesión
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