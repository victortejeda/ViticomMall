import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    let tabs = [
        TabItem(icon: "house", title: "Home"),
        TabItem(icon: "magnifyingglass", title: "Discover"),
        TabItem(icon: "bag", title: "Orders"),
        TabItem(icon: "person", title: "Profile")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                        
                        Text(tabs[index].title)
                            .font(.caption2)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct TabItem {
    let icon: String
    let title: String
} 