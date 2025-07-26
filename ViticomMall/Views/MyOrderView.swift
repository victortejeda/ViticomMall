import SwiftUI

struct MyOrderView: View {
    @State private var selectedFilter = "All"
    @AppStorage("loggedUser") var loggedUser: String = ""
    
    let filters = ["All", "Processing", "Shipped", "Delivered", "Cancelled"]
    
    // Determinar si mostrar datos de ejemplo o estado vacío
    var shouldShowSampleData: Bool {
        // Solo mostrar datos de ejemplo si el usuario es "admin" o tiene un nombre específico
        // Para usuarios nuevos, mostrar estado vacío
        return loggedUser.lowercased() == "admin" || loggedUser.lowercased() == "test"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if shouldShowSampleData {
                    // Mostrar datos de ejemplo para usuarios de prueba
                    OrdersWithDataView(selectedFilter: $selectedFilter)
                } else {
                    // Mostrar estado vacío para usuarios nuevos
                    EmptyOrdersView()
                }
            }
            .navigationTitle("My Orders")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct OrdersWithDataView: View {
    @Binding var selectedFilter: String
    
    let filters = ["All", "Processing", "Shipped", "Delivered", "Cancelled"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Filter tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(filters, id: \.self) { filter in
                        CategoryChip(
                            title: filter,
                            isSelected: selectedFilter == filter
                        ) {
                            selectedFilter = filter
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 8)
            
            // Orders list
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(sampleOrders) { order in
                        if selectedFilter == "All" || order.status.title == selectedFilter {
                            OrderStatusCardView(
                                orderNumber: order.orderNumber,
                                orderDate: order.orderDate,
                                status: order.status,
                                items: order.items
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
        }
    }
}

struct EmptyOrdersView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Icono
            Image(systemName: "bag")
                .font(.system(size: 80))
                .foregroundColor(.gray)
            
            // Título
            Text("No tienes pedidos aún")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // Descripción
            Text("Cuando hagas tu primera compra, aparecerá aquí para que puedas hacer seguimiento.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            // Botón para ir a comprar
            Button(action: {
                // Aquí podrías navegar a la tienda
            }) {
                HStack {
                    Image(systemName: "cart")
                    Text("Comenzar a Comprar")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

// Sample data
let sampleOrders: [OrderData] = [
    OrderData(
        orderNumber: "ORD-001",
        orderDate: "July 15, 2024",
        status: .delivered,
        items: [
            OrderItem(name: "Kit Decoración Cumpleaños", quantity: 1, price: 35.00, icon: "balloon.2.fill"),
            OrderItem(name: "Globos Metálicos", quantity: 2, price: 25.00, icon: "balloon.fill")
        ]
    ),
    OrderData(
        orderNumber: "ORD-002",
        orderDate: "July 18, 2024",
        status: .inTransit,
        items: [
            OrderItem(name: "Centro de Mesa Boda", quantity: 1, price: 45.00, icon: "heart.circle.fill"),
            OrderItem(name: "Luces LED Fiesta", quantity: 1, price: 15.00, icon: "sparkles")
        ]
    ),
    OrderData(
        orderNumber: "ORD-003",
        orderDate: "July 20, 2024",
        status: .processing,
        items: [
            OrderItem(name: "Gorra Graduación", quantity: 1, price: 20.00, icon: "graduationcap.fill"),
            OrderItem(name: "Set Baby Shower", quantity: 1, price: 50.00, icon: "gift.fill")
        ]
    )
]

struct OrderData {
    let orderNumber: String
    let orderDate: String
    let status: OrderStatus
    let items: [OrderItem]
}

extension OrderData: Identifiable {
    var id: String { orderNumber }
} 