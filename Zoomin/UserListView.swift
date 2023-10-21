import SwiftUI

struct UserListView: View {
    @Environment(UserStore.self) var userStore
    
    var users: [User] {
        userStore.values.values.sorted(by: { $0.id.rawValue < $1.id.rawValue })
    }
    
    func load() async {
        do {
            try await userStore.loadAllValues()
        } catch {
            // Error handling
            print(error)
        }
    }

    var body: some View {
        List(users) { user in
            NavigationLink {
                UserView(id: user.id)
            } label: {
                Text(user.name)
            }
        }
        .listStyle(.plain)
        .task {
            await load()
        }
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
    .environment(UserStore(userRepository: UserRepository.shared))
}
