import SwiftUI

struct NotificationsView: View {
    @State private var notifications: [NotificationItem] = sampleNotifications
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if notifications.isEmpty {
                    EmptyNotificationsView()
                } else {
                    List {
                        ForEach(notifications) { notification in
                            NotificationRow(notification: notification)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: deleteNotification)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button("Clear All") {
                notifications.removeAll()
            })
        }
    }
    
    private func deleteNotification(offsets: IndexSet) {
        notifications.remove(atOffsets: offsets)
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    @State private var isRead = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: notification.icon)
                .font(.title2)
                .foregroundColor(notification.color)
                .frame(width: 40, height: 40)
                .background(notification.color.opacity(0.1))
                .clipShape(Circle())
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(notification.message)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text(notification.timeAgo)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Unread indicator
            if !isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onTapGesture {
            withAnimation {
                isRead = true
            }
        }
    }
}

struct EmptyNotificationsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bell.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Notifications")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("You're all caught up! We'll notify you when there's something new.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let icon: String
    let color: Color
    let timeAgo: String
    let type: NotificationType
}

enum NotificationType {
    case order
    case promotion
    case system
    case reminder
}

let sampleNotifications: [NotificationItem] = [
    NotificationItem(
        title: "Order Shipped!",
        message: "Your order ORD-001 has been shipped and is on its way to you.",
        icon: "truck.fill",
        color: .green,
        timeAgo: "2 hours ago",
        type: .order
    ),
    NotificationItem(
        title: "Special Offer!",
        message: "Get 20% off on all birthday decorations. Limited time only!",
        icon: "tag.fill",
        color: .orange,
        timeAgo: "1 day ago",
        type: .promotion
    ),
    NotificationItem(
        title: "Order Delivered",
        message: "Your order ORD-002 has been successfully delivered.",
        icon: "checkmark.circle.fill",
        color: .blue,
        timeAgo: "2 days ago",
        type: .order
    ),
    NotificationItem(
        title: "Welcome to VitiMall!",
        message: "Thank you for joining us. Start exploring our amazing products.",
        icon: "hand.wave.fill",
        color: .purple,
        timeAgo: "3 days ago",
        type: .system
    ),
    NotificationItem(
        title: "Payment Successful",
        message: "Your payment for order ORD-003 has been processed successfully.",
        icon: "creditcard.fill",
        color: .green,
        timeAgo: "4 days ago",
        type: .order
    )
] 