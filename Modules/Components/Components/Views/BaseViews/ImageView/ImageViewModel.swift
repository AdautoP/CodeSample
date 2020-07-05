//
//  ImageViewModel.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import RxSwift
import UIKit

class ImageViewModel {
    
    var emptyImage: UIImage
    
    static let cache = NSCache<NSString, UIImage>()
    
    init(emptyImage: UIImage = Asset.imageNotFound.image) {
        self.emptyImage = emptyImage
    }
    
    func getImageFromUrl(_ urlString: String) -> Observable<UIImage> {
        if let cachedImage = Self.cache.object(forKey: urlString as NSString) {
            return .just(cachedImage)
        }
        
        guard let url = URL(string: urlString) else {
            return Observable.just(emptyImage)
        }
        let request = URLRequest(url: url)
        return URLSession
            .shared
            .rx
            .data(request: request)
            .map { UIImage(data: $0) ?? self.emptyImage }
            .do(onNext: { Self.cache.setObject($0, forKey: urlString as NSString) })
    }
}
