//
//  ViewModel.swift
//  MVVMKit
//
//  Created by Gabriele Trabucco on 26/06/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation

/// This empty protocol identify a ViewModel object in the MVVM Design Pattern.
public protocol ViewModel { }

/**
 An object conforms the `ViewModelHolder` is forced to keep a reference of 
 a specific instance of ViewModel. A tipical `ViewModelHolder` is a
 ViewController. Doing this, all the *Massive* logic tipical of the MVC 
 is moved away from the ViewController to the specific ViewModel. 
 At this point the ViewController will need to focus just on the UI and the
 User Interaction redirecting that user actions to the suitable function
 of the ViewModel.
 */
public protocol ViewModelHolder {
    
    /// The associated Concrete ViewModel object Type.
    associatedtype VM: ViewModel
    
    /// The associated ViewModel instance.
    var viewModel: VM? { get }
}
/**
 In addition to holding the viewModel instance an object may also require
 to observe changes of the retained viewModel. You can choice your
 preferred observation technique, like KVO for Objc Object or Notification 
 or even Reactive pattern, and react the changes to update your views.
 **You must call** `bind()` **whenever is appropriate for your ViewModelObserver**
 (i.e. `viewDidLoad()`)
 */
public protocol ViewModelObserver : ViewModelHolder {
    
    /// The binding function when the observation of the viewModel starts.
    func bind()
}
