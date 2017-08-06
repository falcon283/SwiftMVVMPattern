//
//  ViewModel.swift
//  MVVMKit
//
//  Created by Gabriele Trabucco on 26/06/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

public protocol ViewModel { }

public protocol ViewModelHolder {
    associatedtype VM: ViewModel
    var viewModel: VM? { get }
}

public protocol ViewModelObserver : ViewModelHolder {
    func bind()
}
