import SwiftUI

struct OrderStatusCardView: View {
    let orderNumber: String
    let orderDate: String
    let status: OrderStatus
    let items: [OrderItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Order #\(orderNumber)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(orderDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                StatusBadge(status: status)
            }
            
            // Items
            ForEach(items) { item in
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(.purple)
                        .frame(width: 40, height: 40)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("Qty: \(item.quantity)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", item.price))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            
            // Total
            HStack {
                Text("Total")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Text("$\(String(format: "%.2f", items.reduce(0) { $0 + $1.price }))")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .padding(.top, 8)
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

struct OrderItem: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Int
    let price: Double
    let icon: String
}

enum OrderStatus {
    case delivered
    case inTransit
    case processing
    
    var title: String {
        switch self {
        case .delivered: return "Delivered"
        case .inTransit: return "In Transit"
        case .processing: return "Processing"
        }
    }
    
    var color: Color {
        switch self {
        case .delivered: return .green
        case .inTransit: return .orange
        case .processing: return .blue
        }
    }
}

struct StatusBadge: View {
    let status: OrderStatus
    
    var body: some View {
        Text(status.title)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(status.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.1))
            .cornerRadius(8)
    }
} 