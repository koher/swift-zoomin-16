import Combine
import Observation

@MainActor @Observable
final class UserListViewState {
    let userStore: UserStore = .shared
    
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
}
