import Combine

@MainActor
final class UserViewState: ObservableObject {
    let userStore: UserStore = .shared
    
    let id: User.ID
    
    @Published private(set) var user: User?
    @Published private(set) var isReloadButtonDisabled: Bool = false
    
    init(id: User.ID) {
        self.id = id
        
        userStore.$values
            .map { values in values[id] }
            .assign(to: &$user)
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
}
