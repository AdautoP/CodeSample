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
    
    override public init() {
        super.init()
        buildScreen()
    }
    
    private let contentView = BaseView()
    private let footerView = BaseView()
    
    private let mainStackView = UIStackView() >> {
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    private let bottomStackView = UIStackView() >> {
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    override open func buildSubviews() {
        super.buildSubviews()
        addSubview(mainStackView)
        
        footerView.addSubview(bottomStackView)
        
        mainStackView.addArrangedSubview(contentView)
        mainStackView.addArrangedSubview(footerView)
    }
    
    override open func buildConstraints() {
        super.buildConstraints()
        mainStackView.edgesToSuperview(usingSafeArea: true)
        
        bottomStackView.edgesToSuperview(insets: .uniform(24))
    }
    
    open func render(_ rows: ScreenRowType? ...) {
        rows.compactMap({ $0 }).forEach {
            switch $0 {
            case let .contentView(contentView): addContentView(contentView)
            case let .button(button): addButton(button)
            }
        }
    }
    
    private func addContentView(_ view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.addSubview(view)
        view.edgesToSuperview()
    }
    
    private func addButton(_ button: UIButton) {
        bottomStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomStackView.addArrangedSubview(button)
    }
    
    open func buildScreen() {}
}
