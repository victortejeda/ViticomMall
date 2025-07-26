import SwiftUI

struct MyOrderView: View {
    @State private var selectedFilter = "All"
    
    let filters = ["All", "Processing", "Shipped", "Delivered", "Cancelled"]
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("My Orders")
            .navigationBarTitleDisplayMode(.large)
        }
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