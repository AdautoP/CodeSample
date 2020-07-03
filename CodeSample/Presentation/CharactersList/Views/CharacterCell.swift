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
        $0.layer.cornerRadius = 4
        $0.layer.shadowRadius = 6
        $0.layer.shadowOffset = CGSize(width: -2, height: -2)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowColor = AppColors.Grays.darkGray.cgColor
    }
    
    private let baseImageView = BaseImageView() >> {
        $0.contentMode = .scaleAspectFit
        $0.layer.maskedCorners = .init(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        contentView.addSubview(cardView)
        cardView.addSubview(baseImageView)
        
        selectionStyle = .none
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        cardView.edgesToSuperview(insets: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        baseImageView.edgesToSuperview(excluding: .right)
        baseImageView.height(96)
        baseImageView.width(96)
    }
    
    func bind(_ response: CharacterResponse) {
        baseImageView.image(from: response.image)
    }
}
