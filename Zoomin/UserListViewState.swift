import Combine

@MainActor
final class UserListViewState: ObservableObject {
    @Published var users: [User] = []
    
    func load() async {
        do {
            users = try await UserRepository.fetchAllValues()
        } catch {
            // Error handling
            print(error)
        }
    }
}
