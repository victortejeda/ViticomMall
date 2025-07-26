import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var isDarkMode = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(spacing: 0) {
                TabBarItem(
                    icon: "house.fill",
                    label: "Home",
                    isSelected: selectedTab == 0,
                    isDarkMode: isDarkMode
                ) {
                    selectedTab = 0
                }
                
                TabBarItem(
                    icon: "magnifyingglass",
                    label: "Search",
                    isSelected: selectedTab == 1,
                    isDarkMode: isDarkMode
                ) {
                    selectedTab = 1
                }
                
                TabBarItem(
                    icon: "bag",
                    label: "Cart",
                    isSelected: selectedTab == 2,
                    isDarkMode: isDarkMode
                ) {
                    selectedTab = 2
                }
                
                TabBarItem(
                    icon: "person",
                    label: "Profile",
                    isSelected: selectedTab == 3,
                    isDarkMode: isDarkMode
                ) {
                    selectedTab = 3
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(isDarkMode ? Color.black : Color.white)
            .cornerRadius(25)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let isDarkMode: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .blue : (isDarkMode ? .white : .gray))
                
                Text(label)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .blue : (isDarkMode ? .white : .gray))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
    }
} 