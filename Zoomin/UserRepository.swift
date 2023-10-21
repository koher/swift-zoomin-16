protocol UserRepositoryProtocol {
    func fetchValue(for id: User.ID) async throws -> User?
    func fetchAllValues() async throws -> [User]
}

struct UserRepository: UserRepositoryProtocol {
    private let values: [User.ID: User] = {
        let values: [User] = [
            .init(id: "A", name: "Name A"),
            .init(id: "B", name: "Name B"),
            .init(id: "C", name: "Name C"),
        ]
        return [User.ID: User](uniqueKeysWithValues: values.map { ($0.id, $0) })
    }()
    
    static let shared: UserRepository = .init()
    
    func fetchValue(for id: User.ID) async throws -> User? {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return values[id]
    }
    
    func fetchAllValues() async throws -> [User] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return values.values.sorted(by: { $0.id.rawValue < $1.id.rawValue })
    }
}
