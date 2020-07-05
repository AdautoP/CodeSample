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
    
    private let viewModel = ImageViewModel()
    
    var emptyImage: UIImage {
        get { viewModel.emptyImage }
        set { viewModel.emptyImage = newValue }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large) >> {
        $0.hidesWhenStopped = true
        $0.color = AppColors.Interface.yellow
    }
    
    override public init(image: UIImage? = nil) {
        super.init(image: image)
        self.image = image
        
        addSubview(activityIndicator)
        clipsToBounds = true
        activityIndicator.centerInSuperview()
        
        bind()
    }
    
    private func bind() {
        viewModel
            .stateObservable
            .observeOn(MainScheduler.instance)
            .do(onNext: {
                switch $0 {
                case .loading: self.activityIndicator.startAnimating()
                default: self.activityIndicator.stopAnimating()
                }
            })
            .map {
                switch $0 {
                case let .success(image): return image
                case .failure: return self.emptyImage
                default: return UIImage()
                }
            }
            .bind(to: rx.image)
            .disposed(by: disposeBag)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func image(from urlString: String) {
        viewModel.getImageFromUrl(urlString)
    }
}
