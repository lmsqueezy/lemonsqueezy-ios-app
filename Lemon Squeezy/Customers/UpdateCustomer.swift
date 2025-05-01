//
//  UpdateCustomer.swift
//  Lemon Squeezy
//
//  Created by Ram Maurya on 01/05/25.
//

import SwiftUI
import LemonSqueezy

struct UpdateCustomer: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var customer: Customer?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("customerId") var customerId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Customer ID", text: $customerId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let body = [
                                "data": [
                                    "type": "customers",
                                    "id": customerId,
                                    "attributes": [
                                        "name": "(Updated via API)"
                                    ]
                                ]
                            ]
                            let result = try await lemon.updateCustomer(customerId, body: body)
                            withAnimation {
                                customer = result.data
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
                    Text("Update Customer")
                }
                .disabled(customerId.isEmpty)
            } footer: {
                Text("Changes name to: (Updated via API)")
            }
            
            if let customer {
                Section("Customer") {
                    LabeledContent("Name", value: customer.attributes.name)
                    LabeledContent("Email", value: customer.attributes.email)
                    LabeledContent("Status", value: customer.attributes.status)
                    LabeledContent("Updated at", value: customer.attributes.updatedAt)
                }
            }
            
            if !errors.isEmpty {
              Section("Errors") {
                ForEach(errors, id: \.self) { error in
                    Text(String(describing: error.localizedDescription))
                }
              }
            }
        }
        .navigationTitle("Update Customer")
    }
}

#Preview {
    UpdateCustomer()
}
