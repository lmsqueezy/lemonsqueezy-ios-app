//
//  CreateCustomer.swift
//  Lemon Squeezy
//
//  Created by Ram Maurya on 01/05/25.
//

import SwiftUI
import LemonSqueezy

struct CreateCustomer: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var customer: Customer?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let body = [
                                "data": [
                                    "type": "customers",
                                    "attributes": [
                                        "name": "John Doe",
                                        "email": "johndoe2@example.com",
                                        "city": "New York",
                                        "region": "NY",
                                        "country": "US"
                                    ],
                                    "relationships": [
                                        "store": [
                                            "data": [
                                                "type": "stores",
                                                "id": "2"
                                            ]
                                        ]
                                    ],
                                ]
                            ]
                            let result = try await lemon.createCustomer(body: body)
                            print(result.data)
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
                    Text("Create Customer")
                }
            }
            
            if let customer {
                Section("Customer") {
                    LabeledContent("Name", value: String(customer.attributes.name))
                    LabeledContent("Email", value: String(customer.attributes.email))
                    LabeledContent("Status", value: String(customer.attributes.status))
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
        .navigationTitle("Create Customer")
    }
}

#Preview {
    CreateCustomer()
}
