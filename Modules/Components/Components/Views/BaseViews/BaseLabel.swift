//
//  BaseLabel.swift
//  Components
//
//  Created by Adauto Pinheiro on 07/07/20.
//

import UIKit

open class BaseLabel: UILabel {
    override open func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
            
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
            
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }
}
