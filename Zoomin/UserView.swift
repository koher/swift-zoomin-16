import SwiftUI

struct UserView: View {
    let id: User.ID
    
    @State private var user: User?
    
    var body: some View {
        VStack {
            Text(user?.name ?? "User Name")
                .redacted(reason: user == nil ? .placeholder : [])
                .font(.title)
        }
        .task {
            do {
                user = try await UserRepository.fetchValue(id: id)
            } catch {
                // Error handling
                print(error)
            }
        }
    }
}

#Preview {
    UserView(id: "A")
}
