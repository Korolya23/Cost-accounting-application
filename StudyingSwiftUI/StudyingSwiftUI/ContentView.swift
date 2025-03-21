//
//  ContentView.swift
//  StudyingSwiftUI
//
//  Created by Artem on 8.03.25.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Сумма", text: $viewModel.newAmount)
                    .keyboardType(.decimalPad)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                
                Picker("Category", selection: $viewModel.selectCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.addExpence()
                    }
                }) {
                    Text("Add Expence")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .bold()
                }
                .disabled(viewModel.newAmount.isEmpty)
            }
            .padding(.horizontal, 20)
            
            
            VStack(spacing: 10) {
                ForEach(viewModel.categories, id: \.self) { category in
                    if let amount = viewModel.totalAmoutByCategory[category] {
                        HStack {
                            Text(category)
                            Spacer()
                            Text("\(amount, specifier: "%.2f") Byn")
                        }
                    }
                }
                .transition(.opacity.combined(with: .scale))
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                
                Text("Total: \(viewModel.totalAmount(), specifier: "%.2f") Byn")
                    .font(.headline)
            }
            
            
            List {
                ForEach(viewModel.expences) { expence in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(expence.amount, specifier: "%.2f") Byn")
                                .font(.headline)
                            Text("\(expence.category)")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        
                        Text(expence.date, style: .date)
                            .font(.caption)
                    }
                }
                .onDelete(perform: viewModel.removeExpence(at:))
                .transition(.opacity.combined(with: .scale))
            }
            .listStyle(PlainListStyle())
            
            
            Chart {
                ForEach(viewModel.expences) { expence in
                    BarMark(
                        x: .value("Category", expence.category),
                        y: .value("Sum", expence.amount)
                    )
                    .foregroundStyle(by: .value("Category", expence.category))
                }
            }
            .frame(height: 200)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .navigationTitle("Expences")
    }
}

#Preview {
    ContentView()
}
