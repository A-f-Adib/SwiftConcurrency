//
//  AsyncAwait.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/11/24.
//

import SwiftUI

class AsyncAwaitViewModel : ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title-1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title-2 : \(Thread.current)"
            
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title2 = "Title-3: \(Thread.current)"
                self.dataArray.append(title2)
            }
        }
    }
}

struct AsyncAwait: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                    Text(data)
            }
        }
        .onAppear{
            viewModel.addTitle1()
            viewModel.addTitle2()
        }
    }
}

#Preview {
    AsyncAwait()
}
