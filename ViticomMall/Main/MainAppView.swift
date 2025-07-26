import SwiftUI

// Modelo de producto de ejemplo
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Double
    let category: String
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
    @State private var selectedCategory: String = "All"
    @State private var showMenu = false
    
    // Datos de ejemplo
    let categories: [Category] = [
        Category(name: "Cumpleaños", icon: "birthday.cake"),
        Category(name: "Bodas", icon: "heart.fill"),
        Category(name: "Graduaciones", icon: "graduationcap.fill"),
        Category(name: "Baby Shower", icon: "gift.fill"),
        Category(name: "Fiestas", icon: "sparkles")
    ]
    
    let allProducts: [Product] = [
        Product(name: "Kit Decoración Cumpleaños", imageName: "balloon.2.fill", price: 35.00, category: "Cumpleaños"),
        Product(name: "Centro de Mesa Boda", imageName: "heart.circle.fill", price: 45.00, category: "Bodas"),
        Product(name: "Gorra Graduación", imageName: "graduationcap.fill", price: 20.00, category: "Graduaciones"),
        Product(name: "Set Baby Shower", imageName: "gift.fill", price: 50.00, category: "Baby Shower"),
        Product(name: "Luces LED Fiesta", imageName: "sparkles", price: 15.00, category: "Fiestas"),
        Product(name: "Globos Metálicos", imageName: "balloon.fill", price: 25.00, category: "Cumpleaños"),
        Product(name: "Velo de Novia", imageName: "heart.fill", price: 80.00, category: "Bodas"),
        Product(name: "Toga Graduación", imageName: "graduationcap", price: 30.00, category: "Graduaciones")
    ]
    
    var filteredProducts: [Product] {
        if selectedCategory == "All" {
            return allProducts
        } else {
            return allProducts.filter { $0.category == selectedCategory }
        }
    }
    
    var body: some View {
        ZStack {
            // Fondo principal
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Barra superior con menú y título
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
                .padding(.bottom, 8)
                
                // Barra de búsqueda
                SearchBarView()
                
                // Filtro de categorías
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        // Botón "All"
                        CategoryChip(
                            title: "All",
                            isSelected: selectedCategory == "All"
                        ) {
                            selectedCategory = "All"
                        }
                        
                        // Categorías específicas
                        ForEach(categories) { category in
                            CategoryChip(
                                title: category.name,
                                isSelected: selectedCategory == category.name
                            ) {
                                selectedCategory = category.name
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 8)
                
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
                
                // Productos filtrados
                HStack {
                    Text("Productos \(selectedCategory == "All" ? "Destacados" : selectedCategory)")
                        .font(.headline)
                    Spacer()
                    Button("Ver todo") {}
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                
                Spacer()
            }
            
            // Tab bar moderna en la parte inferior
            VStack {
                Spacer()
                TabBarView()
            }
            
            // Sidebar (menú lateral)
            if showMenu {
                HStack {
                    SidebarView()
                        .transition(.move(edge: .leading))
                    Spacer()
                }
                .background(Color.black.opacity(0.3))
                .onTapGesture {
                    withAnimation {
                        showMenu = false
                    }
                }
            }
        }
        .animation(.easeInOut, value: showMenu)
    }
}

struct ProductCard: View {
    let product: Product
    
    var body: some View {
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