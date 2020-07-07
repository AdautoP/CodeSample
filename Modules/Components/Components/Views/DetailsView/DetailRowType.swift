//
//  DetailRowType.swift
//  Components
//
//  Created by Adauto Pinheiro on 06/07/20.
//

import UIKit

public enum DetailRowType {
    case header(String)
    case name(String)
    case status(StatusRepresentable)
    case vText(title: String, value: String)
    case view(UIView)
}
