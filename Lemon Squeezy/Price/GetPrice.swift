//
//  GetPrice.swift
//  Lemon Squeezy
//
//  Created by Ram Ratan Maurya on 07/10/23.
//

import SwiftUI
import LemonSqueezy

struct GetPrice: View {
    @EnvironmentObject var lemon: LemonSqueezy
    @State var price: Price?
    @State var errors: [LemonSqueezyAPIError] = []
    @SceneStorage("priceId") var priceId = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Price ID", text: $priceId)
                  .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            let result = try await lemon.getPrice(priceId)
                            withAnimation {
                                price = result.data
                                errors = result.errors ?? []
                            }
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
                    Text("Get Price")
                }
                .disabled(priceId.isEmpty)
            }
            
            if let price {
                Section("Price") {
                    LabeledContent("Variant ID", value: String(price.attributes.variantId))
                    LabeledContent("Category", value: price.attributes.category)
                    LabeledContent("Scheme", value: price.attributes.scheme)
                    LabeledContent("Package size", value: String(price.attributes.packageSize))
                    LabeledContent("Tax code", value: price.attributes.taxCode)
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
        .navigationTitle("Get Price")
    }
}

#Preview {
    GetPrice()
}
