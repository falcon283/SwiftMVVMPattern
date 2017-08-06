//
//  Presenter.swift
//  MVVMKit
//
//  Created by FaLcON2 on 31/07/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

open class Presenter<V: View, VM: ViewModel> {
    public init() { }
    open func update(view: V, with viewModel: VM) { }
}

// IBOutlet Support

@objc open class AnyPresenter : NSObject {
    open func presenter() -> Any? { return nil }
}

public protocol Presentable {
    associatedtype PV: View
    associatedtype PVM: ViewModel
    var presenter: Presenter<PV, PVM>? { get set }
}

public protocol IBPresentable: Presentable {
    var presenterObject: AnyPresenter? { get set }
}
