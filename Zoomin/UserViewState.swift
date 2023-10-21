import Combine

@MainActor
final class UserViewState: ObservableObject {
    let id: User.ID
    
    @Published private(set) var user: User?
    @Published private(set) var isReloadButtonDisabled: Bool = false
    
    init(id: User.ID) {
        self.id = id
    }

    func load() async {
        isReloadButtonDisabled = true
        defer { isReloadButtonDisabled = false}
        
        do {
            user = try await UserRepository.fetchValue(id: id)
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
