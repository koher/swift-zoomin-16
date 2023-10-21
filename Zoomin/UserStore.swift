import Combine
import Observation

@Observable
final class UserStore {
    private(set) var values: [User.ID: User] = [:]
    
    private let userRepository: any UserRepositoryProtocol
    
    init(userRepository: any UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func loadValue(for id: User.ID) async throws {
        if let value = try await userRepository.fetchValue(for: id) {
            values[value.id] = value
        } else {
            values.removeValue(forKey: id)
        }
    }
    
    func loadAllValues() async throws {
        let values = try await userRepository.fetchAllValues()
        self.values = .init(uniqueKeysWithValues: values.map { ($0.id, $0) })
    }
}
