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
}

struct DownloadImageAsync: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DownloadImageAsync()
}
