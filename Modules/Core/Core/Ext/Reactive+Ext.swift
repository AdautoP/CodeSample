//
//  Reactive+Ext.swift
//  CodeSample
//
//  Created by adauto.pinheiro on 26/06/20.
//

import RxCocoa
import RxSwift
import UIKit

extension Observable {
    func displayable(retryAction: (() -> Void)?) -> Observable<Display<Element>> {
        self
            .map { Display.success($0) }
            .ifEmpty(default: .idle)
            .startWith(Display<Element>.loading)
            .catchError { .just(Display.failure($0, retryAction)) }
            .observeOn(MainScheduler.instance)
    }

    func displayableWithoutLoading(retryAction: (() -> Void)?) -> Observable<Display<Element>> {
        self
            .map { Display.success($0) }
            .ifEmpty(default: .idle)
            .catchError { .just(Display.failure($0, retryAction)) }
            .observeOn(MainScheduler.instance)
    }
}
