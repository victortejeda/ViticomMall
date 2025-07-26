import SwiftUI

struct SidebarView: View {
    @Binding var isDarkMode: Bool
    @AppStorage("loggedUser") var loggedUser: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var showSettings = false
    @State private var showSupport = false
    @State private var showAboutUs = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.purple)
                
                VStack(spacing: 4) {
                    Text(loggedUser.isEmpty ? "Usuario" : loggedUser)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Cliente Premium")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 40)
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
            
            // Menu items
            VStack(spacing: 0) {
                SidebarMenuItem(
                    icon: "house",
                    title: "Inicio",
                    action: {}
                )
                
                SidebarMenuItem(
                    icon: "magnifyingglass",
                    title: "Descubrir",
                    action: {}
                )
                
                SidebarMenuItem(
                    icon: "bag",
                    title: "Mis Pedidos",
                    action: {}
                )
                
                SidebarMenuItem(
                    icon: "heart",
                    title: "Favoritos",
                    action: {}
                )
                
                SidebarMenuItem(
                    icon: "person",
                    title: "Mi Perfil",
                    action: {}
                )
                
                Divider()
                    .padding(.vertical, 8)
                
                SidebarMenuItem(
                    icon: "gearshape",
                    title: "Configuración",
                    action: { showSettings = true }
                )
                
                SidebarMenuItem(
                    icon: "questionmark.circle",
                    title: "Soporte",
                    action: { showSupport = true }
                )
                
                SidebarMenuItem(
                    icon: "info.circle",
                    title: "Acerca de",
                    action: { showAboutUs = true }
                )
                
                Divider()
                    .padding(.vertical, 8)
                
                // Dark mode toggle
                HStack {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .foregroundColor(.purple)
                        .frame(width: 24)
                    
                    Text("Modo Oscuro")
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(.systemBackground))
            }
            
            Spacer()
            
            // Logout button
            Button(action: {
                showLogoutAlert = true
            }) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                    Text("Cerrar Sesión")
                        .foregroundColor(.red)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .frame(width: 280)
        .background(Color(.systemBackground))
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showSupport) {
            SupportView()
        }
        .sheet(isPresented: $showAboutUs) {
            AboutUsView()
        }
        .alert("Cerrar Sesión", isPresented: $showLogoutAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Cerrar Sesión", role: .destructive) {
                logout()
            }
        } message: {
            Text("¿Estás seguro de que quieres cerrar sesión?")
        }
    }
    
    private func logout() {
        // Limpiar datos del usuario
        loggedUser = ""
        isLoggedIn = false
        
        // También limpiar otros datos relacionados
        UserDefaults.standard.removeObject(forKey: "loggedUser")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}

struct SidebarMenuItem: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .frame(width: 24)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
} 