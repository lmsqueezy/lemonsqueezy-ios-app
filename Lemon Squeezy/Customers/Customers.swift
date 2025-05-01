//
//  Customers.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 28/03/23.
//

import SwiftUI

struct Customers: View {
    var body: some View {
        Form {
            Section("Get customers") {
                NavigationLink(destination: GetCustomers()) { MethodRow(label: "`getCustomers()`", method: .GET) }
                NavigationLink(destination: GetCustomer()) { MethodRow(label: "`getCustomer(_ customerId)`", method: .GET) }
                NavigationLink(destination: CreateCustomer()) { MethodRow(label: "`createCustomer(body)`", method: .POST) }
                NavigationLink(destination: UpdateCustomer()) { MethodRow(label: "`updateCustomer(_ customerId)`", method: .PATCH) }
            }
        }
        .navigationTitle("Customers")
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        Customers()
    }
}
