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
    
    //select single image
    @Published private(set) var selectedImage: NSImage? = nil
    @Published var imageSelection : PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    
    //select multiple image
    @Published private(set) var selectedImages: [NSImage] = []
    @Published var imageSelections : [PhotosPickerItem] = [] {
        didSet {
            setImages(from: imageSelections)
        }
    }
    
    
    //func to select single image
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
    
    
    //func to select multiple image
    private func setImages(from selections: [PhotosPickerItem]) {
        
        Task {
            var images: [NSImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                    if let nsImage = NSImage(data: data) {
                        images.append(nsImage)
                    }
                }
            }
           selectedImages = images
        }
    }
}

struct PhotoPicker: View {
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Hello")
            
            
            //for select single image
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
            
            //for select multiple images
            if !viewModel.selectedImages.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.selectedImages, id: \.self) { image in
                            Image(nsImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            PhotosPicker(selection: $viewModel.imageSelections) {
                Text("Open Photo picker")
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    PhotoPicker()
}
