//
//  Affiliates.swift
//  Lemon Squeezy
//
//  Created by Ram Maurya on 01/05/25.
//

import SwiftUI

struct Affiliates: View {
    var body: some View {
        Form {
            Section("Get Affiliates") {
                NavigationLink(destination: GetAffiliates()) { MethodRow(label: "`getAffiliates()`", method: .GET) }
                NavigationLink(destination: GetAffiliate()) { MethodRow(label: "`getAffiliate(_ affiliateId)`", method: .GET) }
            }
        }
        .navigationTitle("Affiliates")
    }
}

#Preview {
    Affiliates()
}
