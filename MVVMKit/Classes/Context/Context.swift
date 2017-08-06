//
//  Context.swift
//  MVVMKit
//
//  Created by Gabriele Trabucco on 26/06/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

public protocol Contexted {
    var context: Any? { get }
}

public protocol Contextable: class, Contexted {
    var context: Any? { get set }
}
