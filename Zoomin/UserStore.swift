import Combine
import Observation

@Observable
final class UserStore {
    private(set) var values: [User.ID: User] = [:]
    
    static let shared: UserStore = .init()
    
    func loadValue(for id: User.ID) async throws {
        if let value = try await UserRepository.fetchValue(for: id) {
            values[value.id] = value
        } else {
            values.removeValue(forKey: id)
        }
    }
    
    func loadAllValues() async throws {
        let values = try await UserRepository.fetchAllValues()
        self.values = .init(uniqueKeysWithValues: values.map { ($0.id, $0) })
    }
}
