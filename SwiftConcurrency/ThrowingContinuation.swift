//
//  ThrowingContinuation.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 15/11/24.
//

import SwiftUI

class ContinuationNetworkManager {
    
    func getData(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
}

class continuationViewModel: ObservableObject {
    
    @Published var image : NSImage? = nil
    let networkManager = ContinuationNetworkManager()
    
    func getImage() async {
        
        guard let url = URL(string: "https://picsum.photos/300")
        else {
            return
        }
        
        do {
            let data = try await networkManager.getData(url: url)
            
            if let image = NSImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print(error)
        }
        
    }
    
}

struct ThrowingContinuation: View {
    
    @StateObject private var viewModel = continuationViewModel()
    
    var body: some View {
       
        ZStack {
            if let image = viewModel.image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.getImage()
        }
    }
}

#Preview {
    ThrowingContinuation()
}
