//
//  ImageLoadManager.swift
//  EatCook
//
//  Created by 이명진 on 8/7/24.
//

import SwiftUI
import Combine

final class ImageLoadManager: ObservableObject {
    
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private static let cache = ImageCache()
    
    private var retryCount = 0
    private var maxRetries = 3
    
    func load(url: URL) {
        if let cachedImage = ImageLoadManager.cache.image(for: url) {
            self.image = cachedImage
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> UIImage? in
                guard let image = UIImage(data: result.data) else {
                    throw ImageDownLoadError.downLoadFail
                }
                return image
            }
            .retry(maxRetries)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
                if let downloadedImage = $0 {
                    ImageLoadManager.cache.insertImage(downloadedImage, for: url)
                }
            }
    }
    
    func upload(url: URL) {
        
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}


final class ImageCache {
    
    private var cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}

enum ImageDownLoadError: Error, LocalizedError {
    case downLoadFail
    
    var errorDescription: String? {
        switch self {
        case .downLoadFail:
            return NSLocalizedString("이미지 다운로드 실패!!!!", comment: "")
        }
    }
}
