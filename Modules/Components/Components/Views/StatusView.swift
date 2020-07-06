//
//  StatusView.swift
//  CodeSample
//
//  Created by Adauto Pinheiro on 03/07/20.
//

import UIKit

public protocol StatusRepresentable {
    var color: UIColor { get }
    var text: String { get }
}

public class StatusView: BaseView {
    
    private let statusIndicatorView = UIView() >> {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let label = UILabel() >> {
        $0.font = .appFont(size: 16, weight: .medium)
        $0.textAlignment = .left
        $0.setHugging(.defaultHigh, for: .vertical)
    }
    
    override public func buildSubviews() {
        super.buildSubviews()
        addSubview(statusIndicatorView)
        addSubview(label)
        
        setHugging(.defaultHigh, for: .vertical)
    }
    
    override public func buildConstraints() {
        super.buildConstraints()
        
        statusIndicatorView.height(8)
        statusIndicatorView.width(8)
        statusIndicatorView.centerYToSuperview()
        statusIndicatorView.leftToSuperview()
        
        label.verticalToSuperview()
        label.leftToRight(of: statusIndicatorView, offset: 8)
        label.rightToSuperview(offset: -8)
    }
    
    override public func buildAditionalConfiguration() {
        super.buildAditionalConfiguration()
        backgroundColor = .clear
    }
    
    public func layout(_ status: StatusRepresentable, style: Style = .cell) {
        statusIndicatorView.backgroundColor = status.color
        label.text = status.text
        label.textColor = style.textColor
    }
    
    public enum Style {
        case cell
        case header
        
        var textColor: UIColor {
            switch self {
            case .cell: return AppColors.Grays.black
            case .header: return AppColors.Grays.black
            }
        }
    }
}
