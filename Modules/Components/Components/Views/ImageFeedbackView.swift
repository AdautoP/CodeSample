//
//  ImageFeedbackView.swift
//  Components
//
//  Created by Adauto Pinheiro on 04/07/20.
//

import UIKit

public class ImageFeedbackView: BaseView {
    
    private let imageView = UIImageView(image: Asset.Errors.default.image) >> {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.setContentCompressionResistancePriority(.init(rawValue: 249), for: .vertical)
        $0.setContentCompressionResistancePriority(.init(rawValue: 249), for: .horizontal)
    }
    
    private let messageTitleLabel = UILabel() >> {
        $0.font = .appFont(size: 24, weight: .bold)
        $0.textColor = AppColors.Grays.darkerGray
        $0.textAlignment = .center
        $0.text = "Oops, something bad happened."
        $0.numberOfLines = 0
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    private let messageSubtitleLabel = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .regular)
        $0.textColor = AppColors.Grays.darkerGray
        $0.textAlignment = .center
        $0.text = "Sorry for the incovenience, try again."
        $0.numberOfLines = 0
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(imageView)
        addSubview(messageTitleLabel)
        addSubview(messageSubtitleLabel)

    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        
        imageView.edgesToSuperview(excluding: .bottom, insets: .uniform(24))
        
        messageTitleLabel.topToBottom(of: imageView, offset: 24)
        messageTitleLabel.horizontalToSuperview(insets: .horizontal(24))
        
        messageSubtitleLabel.topToBottom(of: messageTitleLabel, offset: 8)
        messageSubtitleLabel.horizontalToSuperview(insets: .horizontal(24))
        messageSubtitleLabel.bottomToSuperview(offset: -24, relation: .equalOrLess)
    }
    
    public func layout(_ showRetryMessage: Bool) {
    }
}
