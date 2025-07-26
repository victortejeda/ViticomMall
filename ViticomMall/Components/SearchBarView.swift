import SwiftUI

struct SearchBarView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
                
                TextField("Search", text: $searchText)
                    .font(.system(size: 16))
                    .onTapGesture {
                        isSearching = true
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(25)
            
            if isSearching {
                Button("Cancel") {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .foregroundColor(.blue)
                .font(.system(size: 16, weight: .medium))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
} 