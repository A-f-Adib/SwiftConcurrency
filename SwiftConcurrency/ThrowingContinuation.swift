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

struct ThrowingContinuation: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ThrowingContinuation()
}
