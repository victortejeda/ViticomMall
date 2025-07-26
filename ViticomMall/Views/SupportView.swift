import SwiftUI

struct SupportView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    let categories = ["All", "Orders", "Payments", "Shipping", "Returns", "Account", "Technical"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBarView()
                
                // Category filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categories, id: \.self) { category in
                            CategoryChip(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 8)
                
                // Quick actions
                VStack(spacing: 16) {
                    Text("Quick Actions")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        QuickActionCard(
                            icon: "phone",
                            title: "Call Support",
                            subtitle: "24/7 Available",
                            color: .green
                        ) {
                            // Call action
                        }
                        
                        QuickActionCard(
                            icon: "message",
                            title: "Live Chat",
                            subtitle: "Instant Help",
                            color: .blue
                        ) {
                            // Chat action
                        }
                        
                        QuickActionCard(
                            icon: "envelope",
                            title: "Email Support",
                            subtitle: "Response in 24h",
                            color: .orange
                        ) {
                            // Email action
                        }
                        
                        QuickActionCard(
                            icon: "questionmark.circle",
                            title: "FAQ",
                            subtitle: "Common Questions",
                            color: .purple
                        ) {
                            // FAQ action
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // FAQ section
                VStack(spacing: 16) {
                    Text("Frequently Asked Questions")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(faqItems) { item in
                            FAQItem(faq: item)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationTitle("Support")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

struct FAQItem: View {
    let faq: FAQItemData
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { isExpanded.toggle() }) {
                HStack {
                    Text(faq.question)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            }
            
            if isExpanded {
                Text(faq.answer)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}

struct FAQItemData: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    let category: String
}

let faqItems: [FAQItemData] = [
    FAQItemData(
        question: "How can I track my order?",
        answer: "You can track your order by going to 'My Orders' section and clicking on the specific order. You'll receive real-time updates via email and push notifications.",
        category: "Orders"
    ),
    FAQItemData(
        question: "What payment methods do you accept?",
        answer: "We accept all major credit cards (Visa, Mastercard, American Express), PayPal, Apple Pay, and Google Pay for secure payments.",
        category: "Payments"
    ),
    FAQItemData(
        question: "How long does shipping take?",
        answer: "Standard shipping takes 3-5 business days. Express shipping (1-2 days) is available for an additional fee. International shipping takes 7-14 business days.",
        category: "Shipping"
    ),
    FAQItemData(
        question: "Can I return or exchange items?",
        answer: "Yes, you can return items within 30 days of delivery. Items must be unused and in original packaging. Contact our support team to initiate a return.",
        category: "Returns"
    ),
    FAQItemData(
        question: "How do I change my account password?",
        answer: "Go to Settings > Security > Change Password. You'll need to enter your current password and then create a new one.",
        category: "Account"
    )
] 