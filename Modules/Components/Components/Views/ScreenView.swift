//
//  ScreenView.swift
//  Components
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import UIKit

public enum ScreenRowType {
    case contentView(UIView)
    case button(UIButton)
}

open class ScreenView: BaseView {
    private let contentStackView = UIStackView() >> {
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = .zero
    }
    
    private let bottomStackView = UIStackView() >> {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    override open func buildSubviews() {
        super.buildSubviews()
        addSubview(contentStackView)
        addSubview(bottomStackView)
    }
    
    override open func buildConstraints() {
        super.buildConstraints()
        
        bottomStackView.edgesToSuperview(excluding: .top)
        
        contentStackView.edgesToSuperview(excluding: .bottom)
        contentStackView.bottomToTop(of: bottomStackView)
    }
    
    open func render(_ rows: ScreenRowType? ...) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        rows.compactMap({ $0 }).forEach {
            switch $0 {
            case let .contentView(contentView): addContentView(contentView)
            case let .button(button): addButton(button)
            }
        }
    }
    
    private func addContentView(_ view: UIView) {
        contentStackView.addArrangedSubview(view)
    }
    
    private func addButton(_ button: UIButton) {
        bottomStackView.addArrangedSubview(button)
    }
    
    open func buildScreen() {}
}
