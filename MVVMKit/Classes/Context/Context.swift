//
//  Context.swift
//  MVVMKit
//
//  Created by Gabriele Trabucco on 26/06/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

/**
 The `Contextable` protocol makes an object able to be set and carry on 
 an arbitrary object as a context object.
 
 **Example**
 
 When a TableViewDataSource requests the new values in order to render 
 its TableView it starts an asynchronous process that begin with the 
 discovery of how many cells compose the TableView and ends asking the 
 specific cells asynchronously. Because this process is asynchronous 
 in some rare cases, like when the refresh rate of the TableView is 
 very high, the user may end up selecting a still visible cell while 
 the DataSource has been invalidated and new cells are about to be 
 rendered. When this happen the indexPath of the visibleCell could be 
 invalid for the DataSource or, if valid, refer a different entity 
 used for the cell render. As you can imagine we are now in an 
 unpredictable situation.
 
 To avoid this kind of inconvenience we can make a CustomCell adopting 
 the Contextable protocol and assign a `context` while the cell is 
 dispatched. Doing this, while the cell view is valid, it will carry 
 the context used to be rendered and that context can be returned back 
 for future actions.
 
 - Note: In a functional environment (RxSwift, ReactiveCocoa) you achieve the
 same result retaining the data inside the injected function
 untill the cell get invalidated.
 */
public protocol Contextable {
    
    /// An arbitrary object to carry on
    var context: Any? { get set }
}
