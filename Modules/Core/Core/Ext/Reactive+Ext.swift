//
//  Reactive+Ext.swift
//  CodeSample
//
//  Created by adauto.pinheiro on 26/06/20.
//

import RxCocoa
import RxSwift
import UIKit

public extension Observable {
    func displayable(retryAction: (() -> Void)?) -> Observable<Display<Element>> {
        self
            .map { Display.success($0) }
            .ifEmpty(default: .idle)
            .startWith(Display<Element>.loading)
            .catch { .just(Display.failure($0, retryAction)) }
            .observe(on: MainScheduler.instance)
    }

    func displayableWithoutLoading(retryAction: (() -> Void)?) -> Observable<Display<Element>> {
        self
            .map { Display.success($0) }
            .ifEmpty(default: .idle)
            .catch { .just(Display.failure($0, retryAction)) }
            .observe(on: MainScheduler.instance)
    }
}
