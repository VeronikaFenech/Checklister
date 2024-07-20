//
//  Image.swift
//  Checklister
//
//  Created by Veronika Hrybanova on 11.07.2024.
//

import SwiftUI
import PhotosUI

struct HashableImage: Hashable, Identifiable {
    let id = UUID()
    let image: Image
    let url: URL
    
    init(image: Image, url: URL) {
        self.image = image
        self.url = url
    }
    
    static func == (lhs: HashableImage, rhs: HashableImage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

func getURL(item: PhotosPickerItem, completionHandler: @escaping (_ result: Result<URL, Error>) -> Void) {
    // Step 1: Load as Data object.
    item.loadTransferable(type: Data.self) { result in
        switch result {
        case .success(let data):
            if let contentType = item.supportedContentTypes.first {
                // Step 2: make the URL file name and a get a file extention.
                let url = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).\(contentType.preferredFilenameExtension ?? "")")
                if let data = data {
                    do {
                        // Step 3: write to temp App file directory and return in completionHandler
                        try data.write(to: url)
                        completionHandler(.success(url))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        case .failure(let failure):
            completionHandler(.failure(failure))
        }
    }
}

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // just send back the first one, which ought to be the only one
    return paths[0]
}
