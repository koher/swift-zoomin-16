import SwiftUI

struct UserView: View {
    let id: User.ID

    @State var isReloadButtonDisabled: Bool = false
    
    @Environment(UserStore.self) var userStore
    
    var user: User? {
        userStore.values[id]
    }
    
    func load() async {
        isReloadButtonDisabled = true
        defer { isReloadButtonDisabled = false}
        
        do {
            try await userStore.loadValue(for: id)
        } catch {
            // Error handling
            print(error)
        }
    }
    
    func reload() {
        isReloadButtonDisabled = true
        Task {
            await load()
        }
    }

    var body: some View {
        VStack {
            Text(user?.name ?? "User Name")
                .redacted(reason: user == nil ? .placeholder : [])
                .font(.title)
            Button("Reload") {
                reload()
            }
            .disabled(isReloadButtonDisabled)
        }
        .task {
            await load()
        }
    }
}

#Preview {
    UserView(id: "A")
        .environment(UserStore(userRepository: PreviewUserRepository(values: [
            "A": User(id: "A", name: "Name A")
        ])))
}

#Preview {
    UserView(id: "A")
        .environment(UserStore(userRepository: PreviewUserRepository(values: [:])))
}

private struct PreviewUserRepository: UserRepositoryProtocol {
    let values: [User.ID: User]
    
    func fetchValue(for id: User.ID) async throws -> User? {
        values[id]
    }
    
    func fetchAllValues() async throws -> [User] {
        values.values.sorted(by: { $0.id.rawValue < $1.id.rawValue })
    }
}
