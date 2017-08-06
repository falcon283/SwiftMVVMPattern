//
//  UserViewController.swift
//  MVVMKitSample
//
//  Created by FaLcON2 on 01/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import MVVMKit

protocol UserVCProtocol : class {
    var viewModel: UserViewModel? { get set }
}

final class UserViewController : UIViewController, UserVCProtocol, ViewModelHolder, IBPresentable {
    
    var viewModel: UserViewModel? = UserViewModel()
    @IBOutlet weak var customView: UserView?
    
    var presenter: Presenter<UserView, UserViewModel>?
    
    @IBOutlet var presenterObject: AnyPresenter? {
        didSet {
            presenter = presenterObject?.presenter() as? Presenter<UserView, UserViewModel>
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = customView, let viewModel = viewModel else {
            return
        }
        
        presenter?.update(view: view, with: viewModel)
    }
}

final class GenderUserViewController : UIViewController, UserVCProtocol, ViewModelHolder, IBPresentable {
    
    var viewModel: UserViewModel? = UserViewModel()
    @IBOutlet weak var customView: GenderView?
    
    var presenter: Presenter<GenderView, UserViewModel>?
    
    @IBOutlet var presenterObject: AnyPresenter? {
        didSet {
            presenter = presenterObject?.presenter() as? Presenter<GenderView, UserViewModel>
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = customView, let viewModel = viewModel else {
            return
        }
        
        presenter?.update(view: view, with: viewModel)
    }
}
