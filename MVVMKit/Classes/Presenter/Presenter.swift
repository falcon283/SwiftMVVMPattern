//
//  Presenter.swift
//  MVVMKit
//
//  Created by FaLcON2 on 31/07/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

/**
 A presenter is a concrete generic class that, given a specific View and a 
 specific ViewModel, is able to update the view in accordance to the 
 viewModel. When a `Presenter` is used, the ViewControllerObserver can be 
 downgraded as simple `ViewModelHolder` and let the `Presenter` the 
 responsability to bind and make up the UI. Keep in mind that a Presenter, 
 as it is, is not storing neither the view or the viewModel. This decision 
 is entirely left to the developer to best fit any project.
 */
open class Presenter<V: View, VM: ViewModel> {
    
    /// Designated Initializer
    public init() { }
    
    /**
     This function is supposed to implement the binding rechnique to 
     observe the viewModel in order to update the view. It must be 
     called when appropriate, i.e. `viewDidLoad()`, `tableView(cellForRowAt:)`.
     
     - Parameter view: The view to update.
     - Parameter viewModel: The viewModel to observe.
     */
    open func update(view: V, with viewModel: VM) { }
}

/// This protocol is suitable if your `Presenter` subclass need to hold the ViewModel.
public protocol ViewModelHolderPresenter {
    
    /// The concrete `ViewModel` class to keep track.
    associatedtype HVM: ViewModel
    
    /**
     The viewModel to keep track. The setter is left to the concrete 
     implementation in order to allow hiding it from public interface.
     */
    var viewModel: HVM? { get }
}

/**
 This protocol is suitable if your `Presenter` subclass need to hold the View.
 
 - Note: This protocol is suitable if your View is a **non** reference type.
 
 - Warning: Never use this protocol if your View is a reference type. Because 
 a view can be the owner of the `Presenter` keep a strong reference of the 
 view insiede the Presenter result in a retain cycle. Please use `WeakHolderPresenter` 
 instead.
 */
public protocol HolderPresenter : ViewModelHolderPresenter {
    
    /// The concrete `View` object to keep track.
    associatedtype HV: View
    
    /**
     The view to update. The setter is left to the concrete implementation 
     in order to allow hiding it from public interface.
     */
    var view: HV? { get }
}

/**
 This protocol is suitable if your `Presenter` subclass need to hold the View reference.
 
 - Note: This protocol is suitable if your View is a reference type. Because
 a view can be the owner of the `Presenter` keep a weak reference of the
 view insiede the Presenter will avoid any retain cycle.
 */
public protocol WeakHolderPresenter : ViewModelHolderPresenter{
    
    /// The concrete `View` instance to keep track.
    associatedtype HV: View, AnyObject
    
    /**
     The view to update. The setter is left to the concrete implementation
     in order to allow hiding it from public interface.
     */
    weak var view: HV? { get }
}

/**
 An object, tipically a `View`, that requires a `Presenter` in order to 
 make up it's content is suitable to adopt the `Presentable` protocol.
 Doing this the `View` will own the presenter asking it to view update 
 the content when appropriate.
 */
public protocol Presentable {
    
    /// The concrete type of `View` the `Presenter` will update.
    associatedtype PV: View
    
    /// The concrete type of `ViewModel` the `Presenter` will observe.
    associatedtype PVM: ViewModel
    
    /// The Presenter instance.
    var presenter: Presenter<PV, PVM>? { get set }
}

// MARK: IBOutlet Support

/**
 If you want to instanciate your specific `Presenter` subclass directly 
 from the xib or storyboard you require an opaque object that will hide 
 the Generic Class to Objective-C. You can simply wrap your generic Swift 
 `Presenter` subclass by creating an `AnyPresenter` subclass that will give 
 you the suitable presenter when required.
 */
open class AnyPresenter : NSObject {
    
    /**
     Implement this method in your subclass to return the suitable `Presenter` subclass
     
     - Returns: A specific `Presenter` subclass that will be then optionally casted.
     */
    open func presenter() -> Any? { return nil }
}

/**
 This protocol is suitable if you want to have a `Presenter` as IBOutlet 
 in your ViewController. Using this protocol you can inject your ViewController 
 using a specific `AnyPresenter` subclass directly from the xib or storyboard.
 
 - Note: Remember to mark `presenterObject` as `@IBOutlet` in your ViewController
 `IBPresentable` implementation:
 
        @IBOutlet var presenterObject: CustomAnyPresenter?
 
 */
public protocol IBPresentable: Presentable {
    
    /// The xib/storyboard injected `AnyPresenter`.
    var presenterObject: AnyPresenter? { get set }
}
