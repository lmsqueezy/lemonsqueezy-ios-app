//
//  GetAffiliate.swift
//  Lemon Squeezy
//
//  Created by Ram Maurya on 01/05/25.
//

import SwiftUI
import LemonSqueezy

struct GetAffiliate: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var affiliate: Affiliate?
    @State var errors: [LemonSqueezyAPIError] = []
    @State var affiliateId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Affiliate ID", text: $affiliateId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getAffiliate(affiliateId)
                            withAnimation {
                                affiliate = result.data
                                errors = result.errors ?? []
                            }
                            print(result)
                        } catch {
                            if let error = error as? LemonSqueezyAPIError {
                                withAnimation{ errors = [error] }
                                print(error)
                            } else {
                                print(error.localizedDescription)
                            }
                        }
                    }
                } label: {
                    Text("Get Affiliate")
                }
                .disabled(affiliateId.isEmpty)
            }
            
            if let affiliate {
                Section("Affiliate") {
                    LabeledContent("Store ID", value: String(affiliate.attributes.storeId))
                    LabeledContent("User ID", value: String(affiliate.attributes.userId))
                    LabeledContent("Email", value: String(affiliate.attributes.userEmail))
                    LabeledContent("Status", value: String(affiliate.attributes.status))
                    LabeledContent("Created", value: String(affiliate.attributes.createdAt))
                    LabeledContent("Total Earnings", value: String(affiliate.attributes.totalEarnings))
                    LabeledContent("Unpaid Earnings", value: String(affiliate.attributes.unpaidEarnings))
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
        .navigationTitle("Get Checkout")
    }
}

#Preview {
    GetAffiliate()
}
