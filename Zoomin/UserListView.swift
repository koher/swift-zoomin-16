import SwiftUI

struct UserListView: View {
    @StateObject private var state: UserListViewState = .init()
    
    var body: some View {
        List(state.users) { user in
            NavigationLink {
                UserView(id: user.id)
            } label: {
                Text(user.name)
            }
        }
        .listStyle(.plain)
        .task {
            await state.load()
        }
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
}
