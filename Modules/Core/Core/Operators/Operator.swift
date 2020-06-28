//
//  Operator.swift
//  CodeSample
//
//  Created by adauto.pinheiro on 26/06/20.
//

import UIKit

infix operator >>: MultiplicationPrecedence

@discardableResult
func >> <Element>(_ left: Element, right: (inout Element) -> Void ) -> Element {
    var mutableLeft = left
    right(&mutableLeft)
    return mutableLeft
}
