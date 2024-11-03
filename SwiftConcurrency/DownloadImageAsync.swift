//
//  DownloadImageAsync.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 4/11/24.
//

import SwiftUI
import AppKit


class ImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> NSImage? {
        guard let data = data,
              let image = NSImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            return nil
        }
        return image
    }
    
    
    func downloadWithAsync() async throws -> NSImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch  {
            throw error
        }
    }
}


class DownloadViewModel: ObservableObject {
    
    @Published var image: NSImage? = nil
    let loader = ImageLoader()
    
    func fetchImage() async {
        
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
    
    
}

struct DownloadImageAsync: View {
    
    @StateObject private var viewModel = DownloadViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

#Preview {
    DownloadImageAsync()
}
