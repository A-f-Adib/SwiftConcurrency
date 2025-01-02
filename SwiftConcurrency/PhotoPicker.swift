//
//  PhotoPicker.swift
//  SwiftConcurrency
//
//  Created by A.F. Adib on 2/1/25.
//

import SwiftUI
import PhotosUI

@MainActor
final class PhotoPickerViewModel : ObservableObject {
    
    @Published private(set) var selectedImage: NSImage? = nil
    @Published var imageSelection : PhotosPickerItem? = nil
}

struct PhotoPicker: View {
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack {
            Text("Hello")
            
            if let image = viewModel.selectedImage {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            }
            
            PhotosPicker(selection: $viewModel.imageSelection) {
                Text("Open Photo picker")
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    PhotoPicker()
}
