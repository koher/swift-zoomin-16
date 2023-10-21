import Combine

@MainActor
final class UserListViewState: ObservableObject {
    let userStore: UserStore = .shared
    
    @Published var users: [User] = []
    
    init() {
        userStore.$values
            .map { values in values.values.sorted(by: { $0.id.rawValue < $1.id.rawValue }) }
            .assign(to: &$users)
    }
    
    func load() async {
        do {
            try await userStore.loadAllValues()
        } catch {
            // Error handling
            print(error)
        }
    }
}
