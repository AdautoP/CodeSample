//
//  DetailRowType.swift
//  Components
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import UIKit

public enum DetailRowType: Equatable {
    case header(String)
    case name(String)
    case status(StatusRepresentable)
    case vText(title: String, value: String)
    case view(UIView)
    
    public static func == (lhs: DetailRowType, rhs: DetailRowType) -> Bool {
        switch (lhs, rhs) {
        case let (.header(string1), .header(string2)):
            return string1 == string2
            
        case let (.name(string1), .name(string2)):
            return string1 == string2
            
        case (.status, status):
            return true
            
        case let (
            .vText(title: title1, value: value1),
            .vText(title: title2, value: value2)
        ):
            return title1 == title2 && value1 == value2
            
        case let (.view(view1), .view(view2)):
            return view1 == view2
            
        default:
            return false
        }
    }
}
