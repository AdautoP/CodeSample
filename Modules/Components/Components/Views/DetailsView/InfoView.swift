//
//  InfoView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public class InfoView: BaseView {
    
    public init(info: String) {
        infoLabel.text = info
        super.init()
    }
    
    private let stackView = UIStackView() >> {
        $0.spacing = 4
        $0.distribution = .fill
        $0.axis = .vertical
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    private let infoLabel = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .light)
        $0.textColor = AppColors.Grays.black
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    private let valueLabel = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .regular)
        $0.textColor = AppColors.Grays.black
        $0.setHugging(.defaultHigh, for: .vertical)
        $0.numberOfLines = 0
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(stackView)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        stackView.edgesToSuperview()
    }
    
    public func bind(value: String) {
        valueLabel.text = value
    }
}
