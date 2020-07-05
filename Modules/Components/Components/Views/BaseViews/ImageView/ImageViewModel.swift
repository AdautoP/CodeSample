//
//  ImageViewModel.swift
//  Components
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import RxSwift
import RxCocoa
import UIKit

class ImageViewModel {
    static let cache = NSCache<NSString, UIImage>()
    
    private let disposeBag = DisposeBag()
    private let stateSubject = PublishSubject<Display<UIImage>>()
    private let requestSubject = PublishSubject<Display<UIImage>>()
    
    private(set) lazy var stateObservable: Observable<Display<UIImage>> = requestSubject.asObservable()
    
    private var disposable: Disposable?
    var emptyImage: UIImage
    
    
    
    init(emptyImage: UIImage = Asset.imageNotFound.image) {
        self.emptyImage = emptyImage
        bind()
    }
    
    func bind() {
        requestSubject
            .do(onNext: {
                switch $0 {
                case .success: self.disposable?.dispose()
                default: break
                }
            })
            .subscribe(onNext: { self.stateSubject.onNext($0 ) })
            .disposed(by: disposeBag)
        
    }
    
    func getImageFromUrl(_ urlString: String) {
        disposable?.dispose()
        if let cachedImage = Self.cache.object(forKey: urlString as NSString) {
            requestSubject.onNext(.success(cachedImage))
        }
        
        guard let url = URL(string: urlString) else {
            requestSubject.onNext(.success(emptyImage))
            return
        }
        
        let request = URLRequest(url: url)
        disposable = URLSession
            .shared
            .rx
            .data(request: request)
            .map { (UIImage(data: $0) ?? self.emptyImage) }
            .do(onNext: { Self.cache.setObject($0, forKey: urlString as NSString) })
            .displayable(retryAction: nil)
            .subscribe(onNext: { self.requestSubject.onNext($0) })
    }
}
