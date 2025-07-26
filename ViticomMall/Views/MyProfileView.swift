import SwiftUI

struct MyProfileView: View {
    @AppStorage("loggedUser") var loggedUser: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var showEditProfile = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile header
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)
                        
                        VStack(spacing: 4) {
                            Text(loggedUser.isEmpty ? "Usuario" : loggedUser)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(userEmail.isEmpty ? "usuario@email.com" : userEmail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Button("Edit Profile") {
                            showEditProfile = true
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 20)
                    
                    // Quick stats
                    HStack(spacing: 20) {
                        StatCard(title: "Orders", value: "0", icon: "bag")
                        StatCard(title: "Favorites", value: "0", icon: "heart")
                        StatCard(title: "Reviews", value: "0", icon: "star")
                    }
                    .padding(.horizontal, 20)
                    
                    // Menu options
                    VStack(spacing: 0) {
                        ProfileMenuItem(icon: "person", title: "Personal Information", action: {})
                        ProfileMenuItem(icon: "location", title: "Shipping Addresses", action: {})
                        ProfileMenuItem(icon: "creditcard", title: "Payment Methods", action: {})
                        ProfileMenuItem(icon: "bell", title: "Notifications", action: {})
                        ProfileMenuItem(icon: "lock", title: "Privacy & Security", action: {})
                        ProfileMenuItem(icon: "questionmark.circle", title: "Help & Support", action: {})
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    
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
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showEditProfile) {
                ProfileFormView()
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
    }
    
    private func logout() {
        // Limpiar datos del usuario
        loggedUser = ""
        userEmail = ""
        isLoggedIn = false
        
        // También limpiar otros datos relacionados
        UserDefaults.standard.removeObject(forKey: "loggedUser")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.purple)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct ProfileMenuItem: View {
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
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
} 