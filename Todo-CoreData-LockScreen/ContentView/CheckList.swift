import SwiftUI

struct CheckList: View {
    // Sample dummy data as [String: String]
    let dummyData: [String: String] = AppLinks
    
    // State for the search bar and selected items
    @State private var searchText: String = ""
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        VStack {
            Text("Select App Links")
                .font(.headline)
                .padding()
            
            // Add the search bar
            SearchBar(text: $searchText)
            
            // Filter the list based on search text
            List(filteredData.keys.sorted(), id: \.self, selection: $selectedItems) { key in
                Text(key)
            }
            .environment(\.editMode, .constant(.active)) // Enables multi-selection
            
            Divider()
            
            Text("Selected Apps:")
                .font(.subheadline)
                .padding(.top)
            
            // Display selected items
            ForEach(Array(selectedItems), id: \.self) { selectedItem in
                Text(selectedItem)
            }
        }
        .padding()
    }
    
    // Filtered data based on search query
    var filteredData: [String: String] {
        if searchText.isEmpty {
            return dummyData
        } else {
            return dummyData.filter { $0.key.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    CheckList()
}
