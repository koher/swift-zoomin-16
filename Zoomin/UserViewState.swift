import Combine

@MainActor
final class UserViewState: ObservableObject {
    let id: User.ID
    
    @Published private(set) var user: User?
    
    init(id: User.ID) {
        self.id = id
    }

    func load() async {
        do {
            user = try await UserRepository.fetchValue(id: id)
        } catch {
            // Error handling
            print(error)
        }
    }
}
