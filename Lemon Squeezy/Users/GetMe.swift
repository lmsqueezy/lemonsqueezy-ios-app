//
//  GetMe.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 19/12/22.
//

import SwiftUI
import LemonSqueezy

struct GetMe: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var user: User?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getMe()
                            withAnimation {
                                user = result.data
                                errors = result.errors ?? []
                            }
                            print(result)
                        } catch {
                            if let error = error as? LemonSqueezyAPIError {
                                withAnimation{ errors = [error] }
                            } else {
                                print(error.localizedDescription)
                            }
                        }
                    }
                } label: {
                    Text("Get currently authenticated user")
                }
            }
            
            if let user {
                LabeledContent("name", value: user.attributes.name)
                LabeledContent("email", value: user.attributes.email)
                LabeledContent("color", value: user.attributes.color)
                LabeledContent("avatarUrl", value: user.attributes.avatarUrl)
                LabeledContent("hasCustomAvatar", value: String(user.attributes.hasCustomAvatar))
                LabeledContent("createdAt", value: user.attributes.createdAt)
                LabeledContent("updatedAt", value: user.attributes.updatedAt)
            }
            
            if !errors.isEmpty {
              Section("Errors") {
                ForEach(errors, id: \.self) { error in
                    Text(String(describing: error.localizedDescription))
                }
              }
            }
        }
        .navigationTitle("Get currently authenticated user")
    }
}

struct GetMe_Previews: PreviewProvider {
    static var previews: some View {
        GetMe()
    }
}
