//
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import AloeStackView
import UIKit

class CharacterDetailsRootView: BaseView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private let stackView = AloeStackView() >> {
        $0.rowInset = .zero
        $0.automaticallyHidesLastSeparator = true
        $0.backgroundColor = AppColors.Grays.lightGray
    }
    
    private let imageHeaderView = ImageHeaderView()
    
    private var imageHeight = NSLayoutConstraint()
    
    override func buildSubviews() {
        super.buildSubviews()
        
        addSubview(stackView)
        
        stackView.addRow(imageHeaderView)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        
        stackView.topToSuperview(usingSafeArea: false)
        stackView.edgesToSuperview(excluding: .top)
        
        imageHeight = imageHeaderView.height(to: stackView, multiplier: 0.3)
    }
    
    func layout(_ character: Character) {
        imageHeaderView.layout(character.image)
    }
}
