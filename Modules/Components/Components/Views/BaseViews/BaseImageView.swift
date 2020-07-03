//
//  BaseImageView.swift
//  Components
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import RxCocoa
import RxSwift
import UIKit

open class BaseImageView: UIImageView {
    private let disposeBag = DisposeBag()
    
    var emptyImage: UIImage
    static let cache = NSCache<NSString, UIImage>()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large) >> {
        $0.hidesWhenStopped = true
        $0.color = AppColors.Interface.yellow
    }
    
    public init(image: UIImage? = nil, emptyImage: UIImage = Asset.imageNotFound.image) {
        self.emptyImage = emptyImage
        super.init(image: image)
        self.image = image ?? emptyImage
        
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func image(from urlString: String) {
        if let cachedImage = Self.cache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession
            .shared
            .rx
            .data(request: request)
            .map { UIImage(data: $0) ?? self.emptyImage }
            .displayable(retryAction: nil)
            .do(onNext: {
                if let value = $0.value {
                    Self.cache.setObject(value, forKey: urlString as NSString)
                }
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                switch $0 {
                case .loading:
                    self.image = nil
                    self.activityIndicator.startAnimating()
                    
                case let .success(image):
                    self.image = image
                    self.activityIndicator.stopAnimating()
                    
                default:
                    self.image = self.emptyImage
                    self.activityIndicator.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }
}
