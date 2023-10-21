import SwiftID

struct User: Identifiable, Sendable {
    var id: ID
    var name: String

    struct ID: StringIDProtocol {
        var rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}
