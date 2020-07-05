//
//  ImageHeaderView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import UIKit

class ImageHeaderView: BaseView {
    let imageView = BaseImageView() >> {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
        $0.setCompressionResistance(.init(rawValue: 249), for: .horizontal)
    }
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    private lazy var blurredBackgroundImageView = BaseImageView() >> {
        $0.addSubview(blurView)
        $0.contentMode = .scaleToFill
        $0.setCompressionResistance(.init(rawValue: 249), for: .vertical)
        $0.setCompressionResistance(.init(rawValue: 249), for: .horizontal)
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(blurredBackgroundImageView)
        addSubview(imageView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        imageView.edgesToSuperview()
        
        blurView.edgesToSuperview()
        blurredBackgroundImageView.edgesToSuperview()
    }
    
    func layout(_ urlString: String) {
        imageView.image(from: urlString)
        blurredBackgroundImageView.image(from: urlString)
    }
}
