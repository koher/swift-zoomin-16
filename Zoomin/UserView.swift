import SwiftUI

struct UserView: View {
    @StateObject private var state: UserViewState
    
    init(id: User.ID) {
        self._state = .init(wrappedValue: UserViewState(id: id))
    }
    
    var body: some View {
        VStack {
            Text(state.user?.name ?? "User Name")
                .redacted(reason: state.user == nil ? .placeholder : [])
                .font(.title)
            Button("Reload") {
                state.reload()
            }
            .disabled(state.isReloadButtonDisabled)
        }
        .task {
            await state.load()
        }
    }
}

#Preview {
    UserView(id: "A")
}
