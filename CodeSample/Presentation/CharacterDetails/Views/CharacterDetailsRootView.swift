//
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import UIKit

class CharacterDetailsRootView: ScreenView {
    
    private let contentView = BaseView()
    
    private let imageHeaderView = ImageHeaderView()
    
    private var imageHeight = NSLayoutConstraint()
    
    override func buildScreen() {
        render(.contentView(contentView))
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        
        contentView.addSubview(imageHeaderView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        
        imageHeaderView.edgesToSuperview(excluding: .bottom)
        imageHeight = imageHeaderView.heightToSuperview(multiplier: 0.3)
    }
    
    func layout(_ character: Character) {
        imageHeaderView.layout(character.image)
    }
}
