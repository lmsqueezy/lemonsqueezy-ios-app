//
//  GetAffiliates.swift
//  Lemon Squeezy
//
//  Created by Ram Maurya on 01/05/25.
//

import SwiftUI
import LemonSqueezy

struct GetAffiliates: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var affiliates: [Affiliate]?
    @State var errors: [LemonSqueezyAPIError] = []
    
    var body: some View {
        Form {
            Section {
                Button {
                    Task {
                        do {
                            let result = try await lemon.getAffiliates()
                            withAnimation {
                                affiliates = result.data
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
                    Text("Get affiliates")
                }
            }
            
            if let affiliates {
                Section {
                    ForEach(affiliates) { affiliate in
                        NavigationLink {
                            GetAffiliate(affiliate: affiliate)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(String(affiliate.attributes.userEmail))
                            }
                        }

                    }
                }
            }
        }
        .navigationTitle("Get affiliates")
    }
}

#Preview {
    GetAffiliates()
}
