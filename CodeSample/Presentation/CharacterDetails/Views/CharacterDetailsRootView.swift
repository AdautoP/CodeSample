//
//  CharacterDetailsRootView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 05/07/20.
//

import AloeStackView
import UIKit

class CharacterDetailsRootView: ScreenView {
    
    private lazy var stackView = AloeStackView() >> {
        $0.rowInset = .zero
        $0.automaticallyHidesLastSeparator = true
        $0.backgroundColor = AppColors.Grays.lightGray
        $0.delegate = self
    }
    
    private let imageHeaderView = ImageHeaderView()
    
    private var imageHeight = NSLayoutConstraint()
    
    override func buildScreen() {
        super.buildScreen()
        render(.contentView(stackView))
        
        stackView.addRow(imageHeaderView)
        imageHeight = imageHeaderView.height(to: stackView, multiplier: 0.4)
    }
    
    func layout(_ character: Character) {
        imageHeaderView.layout(character)
    }
}

extension CharacterDetailsRootView: UIScrollViewDelegate {
    
}
