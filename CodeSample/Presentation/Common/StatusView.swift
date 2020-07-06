//
//  StatusView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

class StatusView: BaseView {
    
    private let statusIndicatorView = UIView() >> {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let label = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .medium)
        $0.textAlignment = .left
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    override func buildSubviews() {
        super.buildSubviews()
        addSubview(statusIndicatorView)
        addSubview(label)
        
        setHugging(.defaultHigh, for: .vertical)
    }
    
    override func buildConstraints() {
        super.buildConstraints()
        
        statusIndicatorView.height(8)
        statusIndicatorView.width(8)
        statusIndicatorView.centerYToSuperview()
        statusIndicatorView.leftToSuperview()
        
        label.verticalToSuperview()
        label.leftToRight(of: statusIndicatorView, offset: 8)
        label.rightToSuperview(offset: -8)
    }
    
    override func buildAditionalConfiguration() {
        super.buildAditionalConfiguration()
        backgroundColor = .clear
    }
    
    func layout(_ status: Character.Status, species: String, style: Style = .cell) {
        statusIndicatorView.backgroundColor = status.color
        label.text = status.text + " - " + species
        label.textColor = style.textColor
    }
    
    enum Style {
        case cell
        case header
        
        var textColor: UIColor {
            switch self {
            case .cell: return AppColors.Grays.black
            case .header: return AppColors.Grays.lightGray
            }
        }
    }
}
