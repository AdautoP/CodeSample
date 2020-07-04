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
        activityIndicator.centerInSuperview()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func image(from urlString: String) {
        viewModel
            .getImageFromUrl(urlString)
            .displayable(retryAction: nil)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                switch $0 {
                case .loading:
                    self.image = nil
                    self.activityIndicator.startAnimating()
                    
                case let .success(image):
                    self.activityIndicator.stopAnimating()
                    self.image = image
                    
                default:
                    self.activityIndicator.stopAnimating()
                    self.image = self.emptyImage
                }
            })
            .disposed(by: disposeBag)
    }
}
