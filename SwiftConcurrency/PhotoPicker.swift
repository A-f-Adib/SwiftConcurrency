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
    @Published var imageSelection : PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let nsImage = NSImage(data: data) {
                    selectedImage = nsImage
                    return
                }
            }
        }
    }
    
}

struct PhotoPicker: View {
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
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
