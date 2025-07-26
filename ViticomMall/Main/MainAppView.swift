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
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var selectedCategory: String = "All"
    @State private var showMenu = false
    @State private var showNotifications = false
    @State private var showCart = false
    @State private var selectedTab = 0
    
    @StateObject private var cartManager = CartManager()
    
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
        Product(name: "Toga Graduación", imageName: "graduationcap", price: 30.00, category: "Graduaciones"),
        Product(name: "Kit Fiesta Temática", imageName: "party.popper", price: 55.00, category: "Fiestas"),
        Product(name: "Decoración Baby Shower Rosa", imageName: "gift.circle", price: 40.00, category: "Baby Shower"),
        Product(name: "Mesa de Dulces", imageName: "birthday.cake.fill", price: 65.00, category: "Cumpleaños"),
        Product(name: "Arco de Globos", imageName: "balloon.2", price: 75.00, category: "Fiestas"),
        Product(name: "Cojines Decorativos", imageName: "heart.square", price: 28.00, category: "Bodas"),
        Product(name: "Diploma Personalizado", imageName: "doc.text", price: 12.00, category: "Graduaciones"),
        Product(name: "Ramo de Globos", imageName: "balloon", price: 32.00, category: "Baby Shower")
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
                    HStack(spacing: 16) {
                        Button(action: { showNotifications.toggle() }) {
                            ZStack {
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                                
                                // Badge de notificaciones
                                if cartManager.totalItems > 0 {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 8)
                                        .offset(x: 8, y: -8)
                                }
                            }
                        }
                        
                        Button(action: { showCart.toggle() }) {
                            ZStack {
                                Image(systemName: "cart")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                                
                                // Badge del carrito
                                if cartManager.totalItems > 0 {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 8)
                                        .offset(x: 8, y: -8)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 8)
                
                // Contenido principal basado en la pestaña seleccionada
                TabView(selection: $selectedTab) {
                    // Home Tab
                    HomeContentView(
                        selectedCategory: $selectedCategory,
                        categories: categories,
                        filteredProducts: filteredProducts,
                        cartManager: cartManager
                    )
                    .tag(0)
                    
                    // Discover Tab
                    DiscoverView()
                        .tag(1)
                    
                    // Orders Tab
                    MyOrderView()
                        .tag(2)
                    
                    // Profile Tab
                    MyProfileView()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Tab bar moderna en la parte inferior
                VStack {
                    Spacer()
                    TabBarView(selectedTab: $selectedTab)
                }
            }
            
            // Sidebar (menú lateral)
            if showMenu {
                HStack {
                    SidebarView(isDarkMode: $isDarkMode)
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
        .sheet(isPresented: $showNotifications) {
            NotificationsView()
        }
        .sheet(isPresented: $showCart) {
            CartView(cartManager: cartManager)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct HomeContentView: View {
    @Binding var selectedCategory: String
    let categories: [Category]
    let filteredProducts: [Product]
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        VStack(spacing: 0) {
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
                        ProductCard(product: product, cartManager: cartManager)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 8)
            
            Spacer()
        }
    }
}

struct ProductCard: View {
    let product: Product
    @ObservedObject var cartManager: CartManager
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .frame(width: 130, height: 130)
                
                Image(systemName: product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.purple)
                
                // Botón de favorito
                Button(action: { 
                    isFavorite.toggle()
                    cartManager.toggleFavorite(product.id.uuidString)
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title3)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
            
            HStack {
                Text("$ \(String(format: "%.2f", product.price))")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                // Botón de agregar al carrito
                Button(action: {
                    cartManager.addToCart(product)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
            }
        }
        .frame(width: 130)
        .onAppear {
            isFavorite = cartManager.isFavorite(product.id.uuidString)
        }
    }
} 