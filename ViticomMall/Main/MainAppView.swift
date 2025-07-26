import SwiftUI

// Modelo de producto de ejemplo
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Double
    let category: String
    let isFeatured: Bool
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
        // Productos Destacados
        Product(name: "Kit Decoración Cumpleaños Premium", imageName: "balloon.2.fill", price: 45.00, category: "Cumpleaños", isFeatured: true),
        Product(name: "Centro de Mesa Boda Elegante", imageName: "heart.circle.fill", price: 65.00, category: "Bodas", isFeatured: true),
        Product(name: "Set Baby Shower Completo", imageName: "gift.fill", price: 75.00, category: "Baby Shower", isFeatured: true),
        Product(name: "Arco de Globos Profesional", imageName: "balloon.2", price: 85.00, category: "Fiestas", isFeatured: true),
        
        // Productos por Categoría
        Product(name: "Gorra Graduación", imageName: "graduationcap.fill", price: 20.00, category: "Graduaciones", isFeatured: false),
        Product(name: "Luces LED Fiesta", imageName: "sparkles", price: 15.00, category: "Fiestas", isFeatured: false),
        Product(name: "Globos Metálicos", imageName: "balloon.fill", price: 25.00, category: "Cumpleaños", isFeatured: false),
        Product(name: "Velo de Novia", imageName: "heart.fill", price: 80.00, category: "Bodas", isFeatured: false),
        Product(name: "Toga Graduación", imageName: "graduationcap", price: 30.00, category: "Graduaciones", isFeatured: false),
        Product(name: "Kit Fiesta Temática", imageName: "party.popper", price: 55.00, category: "Fiestas", isFeatured: false),
        Product(name: "Decoración Baby Shower Rosa", imageName: "gift.circle", price: 40.00, category: "Baby Shower", isFeatured: false),
        Product(name: "Mesa de Dulces", imageName: "birthday.cake.fill", price: 65.00, category: "Cumpleaños", isFeatured: false),
        Product(name: "Cojines Decorativos", imageName: "heart.square", price: 28.00, category: "Bodas", isFeatured: false),
        Product(name: "Diploma Personalizado", imageName: "doc.text", price: 12.00, category: "Graduaciones", isFeatured: false),
        Product(name: "Ramo de Globos", imageName: "balloon", price: 32.00, category: "Baby Shower", isFeatured: false),
        Product(name: "Candeleros Elegantes", imageName: "flame", price: 35.00, category: "Bodas", isFeatured: false),
        Product(name: "Kit Graduación Completo", imageName: "graduationcap.fill", price: 50.00, category: "Graduaciones", isFeatured: false),
        Product(name: "Decoración Fiesta Neon", imageName: "lightbulb", price: 42.00, category: "Fiestas", isFeatured: false)
    ]
    
    var featuredProducts: [Product] {
        allProducts.filter { $0.isFeatured }
    }
    
    var filteredProducts: [Product] {
        if selectedCategory == "All" {
            return allProducts.filter { !$0.isFeatured } // Excluir destacados de la lista general
        } else {
            return allProducts.filter { $0.category == selectedCategory && !$0.isFeatured }
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
                        featuredProducts: featuredProducts,
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
    let featuredProducts: [Product]
    let filteredProducts: [Product]
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Barra de búsqueda
                SearchBarView()
                
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
                
                // Productos Destacados
                VStack(spacing: 16) {
                    HStack {
                        Text("Productos Destacados")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Button("Ver todos") {}
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    // Grid de productos destacados (2 columnas)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        ForEach(featuredProducts) { product in
                            FeaturedProductCard(product: product, cartManager: cartManager)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Filtro de categorías
                VStack(spacing: 16) {
                    HStack {
                        Text("Explorar por Categoría")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
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
                        .padding(.horizontal)
                    }
                }
                
                // Productos por categoría
                VStack(spacing: 16) {
                    HStack {
                        Text(selectedCategory == "All" ? "Todos los Productos" : "Productos \(selectedCategory)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Button("Ver todo") {}
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    // Grid de productos por categoría (2 columnas)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product, cartManager: cartManager)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 100) // Espacio para el tab bar
            }
            .padding(.top, 8)
        }
    }
}

struct FeaturedProductCard: View {
    let product: Product
    @ObservedObject var cartManager: CartManager
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .frame(height: 160)
                
                Image(systemName: product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.purple)
                
                // Badge destacado
                VStack {
                    Text("⭐")
                        .font(.title2)
                    Text("Destacado")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.orange)
                .cornerRadius(8)
                .padding(8)
                
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Botón de agregar al carrito
                    Button(action: {
                        cartManager.addToCart(product)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .onAppear {
            isFavorite = cartManager.isFavorite(product.id.uuidString)
        }
    }
}

struct ProductCard: View {
    let product: Product
    @ObservedObject var cartManager: CartManager
    @State private var isFavorite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .frame(height: 140)
                
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    
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
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        .onAppear {
            isFavorite = cartManager.isFavorite(product.id.uuidString)
        }
    }
} 