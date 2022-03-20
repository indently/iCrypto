//
//  ContentView.swift
//  iCrypto
//
//  Created by Federico on 20/03/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Stepper("Amount: \(Int(vm.amount))€", value: $vm.amount, step: 100)
                    Slider(value: $vm.amount, in: 1...10_000)
                    Divider()
                }
                .padding()

                // Use Rate.sampleRates for debugging
                List(vm.filteredRates) { item in
                    HStack() {
                        Text(item.asset_id_quote)
                            .bold()
                        Text("€\(vm.calcRate(rate: item), specifier: "%.2f")")
                    }
                }
                .listStyle(.plain)
                .searchable(text: $vm.searchText)
            }
            .onAppear(perform: vm.refreshData)
            .navigationTitle("iCrypto")
            .toolbar {
                ToolbarItem {
                    Button("Refresh", action: vm.refreshData)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
