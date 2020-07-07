//
//  CharacterCell.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 02/07/20.
//

import UIKit

class CharacterCell: BaseTableViewCell {
    
    private let cardView = BaseView() >> {
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 16
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: -2, height: 2)
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowColor = AppColors.Grays.darkerGray.cgColor
    }
    
    private let baseImageView = BaseImageView() >> {
        $0.contentMode = .scaleAspectFill
        $0.layer.maskedCorners = .init(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        $0.layer.cornerRadius = 16
        $0.setContentCompressionResistancePriority(.init(rawValue: 249), for: .vertical)
        $0.setContentCompressionResistancePriority(.init(rawValue: 249), for: .horizontal)
    }
    
    private let nameLabel = UILabel() >> {
        $0.font = .appFont(size: 20, weight: .bold)
        $0.setHugging(.defaultHigh, for: .vertical)
        $0.numberOfLines = 0
    }
    
    private let statusView = StatusView()
    
    private let lastLocationInfoView = InfoView(info: "Last Location")
    
    override func buildSubviews() {
        super.buildSubviews()
        contentView.addSubview(cardView)
        cardView.addSubview(baseImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(statusView)
        cardView.addSubview(lastLocationInfoView)
        
        selectionStyle = .none
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        cardView.edgesToSuperview(insets: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        baseImageView.edgesToSuperview(excluding: .right)
        baseImageView.heightToSuperview()
        baseImageView.widthToSuperview(multiplier: 0.4)
        
        nameLabel.leftToRight(of: baseImageView, offset: 16)
        nameLabel.rightToSuperview(offset: -16)
        nameLabel.topToSuperview(offset: 8)
        
        statusView.leftToRight(of: baseImageView, offset: 16)
        statusView.topToBottom(of: nameLabel)
        statusView.rightToSuperview(offset: -16)
        
        lastLocationInfoView.topToBottom(of: statusView, offset: 16)
        lastLocationInfoView.leftToRight(of: baseImageView, offset: 16)
        lastLocationInfoView.rightToSuperview(offset: -16)
        lastLocationInfoView.bottomToSuperview(offset: -8)
        
    }
    
    func layout(_ response: Character) {
        baseImageView.image(from: response.image)
        nameLabel.text = response.name
        statusView.layout(response.status)
        lastLocationInfoView.bind(value: response.lastLocation.name)
    }
}
