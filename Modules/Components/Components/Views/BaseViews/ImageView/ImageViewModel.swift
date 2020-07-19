//
//  ImageViewModel.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import RxSwift
import UIKit

class ImageViewModel {
    static let cache = NSCache<NSString, UIImage>()
    
    private let disposeBag = DisposeBag()
    private let stateSubject = PublishSubject<Display<UIImage>>()
    
    private(set) lazy var stateObservable: Observable<Display<UIImage>> = stateSubject.asObservable()
    
    private var disposable: Disposable?
    var emptyImage: UIImage
    
    init(emptyImage: UIImage = Asset.imageNotFound.image) {
        self.emptyImage = emptyImage
    }
    
    func getImageFromUrl(_ urlString: String) {
        disposable?.dispose()
        if let cachedImage = Self.cache.object(forKey: urlString as NSString) {
            return stateSubject.onNext(.success(cachedImage))
        } else {
            guard let url = URL(string: urlString) else {
                return stateSubject.onNext(.success(emptyImage))
            }
            
            let request = URLRequest(url: url)
            disposable = URLSession
                .shared
                .rx
                .data(request: request)
                .map { (UIImage(data: $0) ?? self.emptyImage) }
                .do(onNext: { Self.cache.setObject($0, forKey: urlString as NSString) })
                .displayable(retryAction: nil)
                .subscribe(onNext: { [weak self] in self?.stateSubject.onNext($0) })
        }
    }
}
