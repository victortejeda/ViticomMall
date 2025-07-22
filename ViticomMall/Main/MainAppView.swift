import SwiftUI

// Modelo de producto de ejemplo
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Double
}

// Modelo de categoría de ejemplo
struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

/// Vista principal de la aplicación después de iniciar sesión (Home de compras para eventos y fiestas)
struct MainAppView: View {
    @Binding var isLoggedIn: Bool
    @AppStorage("loggedUser") var loggedUser: String = ""
    // Datos de ejemplo
    let categories: [Category] = [
        Category(name: "Cumpleaños", icon: "birthday.cake"),
        Category(name: "Bodas", icon: "heart.fill"),
        Category(name: "Graduaciones", icon: "graduationcap.fill"),
        Category(name: "Baby Shower", icon: "gift.fill"),
        Category(name: "Fiestas", icon: "sparkles")
    ]
    let products: [Product] = [
        Product(name: "Kit Decoración Cumpleaños", imageName: "balloon.2.fill", price: 35.00),
        Product(name: "Centro de Mesa Boda", imageName: "heart.circle.fill", price: 45.00),
        Product(name: "Gorra Graduación", imageName: "graduationcap.fill", price: 20.00),
        Product(name: "Set Baby Shower", imageName: "gift.fill", price: 50.00),
        Product(name: "Luces LED Fiesta", imageName: "sparkles", price: 15.00)
    ]
    @State private var selectedCategory: UUID?
    @State private var showMenu = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Barra superior
                HStack {
                    Button(action: { showMenu.toggle() }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Text("VitiMall Eventos")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                // Categorías
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(categories) { category in
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(selectedCategory == category.id ? Color.blue : Color(.systemGray5))
                                        .frame(width: 48, height: 48)
                                    Image(systemName: category.icon)
                                        .foregroundColor(selectedCategory == category.id ? .white : .gray)
                                        .font(.title2)
                                }
                                Text(category.name)
                                    .font(.caption)
                                    .foregroundColor(selectedCategory == category.id ? .blue : .gray)
                            }
                            .onTapGesture {
                                selectedCategory = category.id
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                // Banner destacado
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 140)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("¡Prepara tu Evento!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Todo para fiestas, bodas, cumpleaños y más.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(24)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                // Productos destacados
                HStack {
                    Text("Productos Destacados")
                        .font(.headline)
                    Spacer()
                    Button("Ver todo") {}
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(products) { product in
                            VStack(alignment: .leading, spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(.systemGray6))
                                        .frame(width: 130, height: 130)
                                    Image(systemName: product.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.purple)
                                }
                                Text(product.name)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .lineLimit(2)
                                Text("$ \(String(format: "%.2f", product.price))")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            .frame(width: 130)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                Spacer()
                // Barra inferior de navegación
                HStack {
                    Spacer()
                    Image(systemName: "house.fill").foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "square.grid.2x2").foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "cart").foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "person").foregroundColor(.gray)
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
            }
            .navigationBarHidden(true)
        }
    }
} 