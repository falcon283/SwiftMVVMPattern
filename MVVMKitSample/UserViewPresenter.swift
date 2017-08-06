//
//  UserViewPresenter.swift
//  MVVMKit
//
//  Created by FaLcON2 on 02/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation
import MVVMKit

class UserViewPresenter : Presenter<UserView, UserViewModel> {
    var primaryColor: UIColor
    var secondaryColor: UIColor
    
    var isTimeEven : Bool {
        return Int(Date().timeIntervalSince1970) % 2 == 0
    }
    
    init(primaryColor: UIColor = UIColor.black, secondaryColor: UIColor = UIColor.gray) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

final class UserViewFullNamePresenter: UserViewPresenter {

    override func update(view: UserView, with viewModel: UserViewModel) {
        view.label?.text = "\(viewModel.name) \(viewModel.surname)"
        view.label?.textColor = isTimeEven ? primaryColor : secondaryColor
    }
}

final class UserViewNamePresenter: UserViewPresenter {
    
    override func update(view: UserView, with viewModel: UserViewModel) {
        view.label?.text = viewModel.name
        view.label?.textColor = isTimeEven ? primaryColor : secondaryColor
    }
}

// IBOutlet Support

class UserViewIBPresenter : AnyPresenter {
    @IBInspectable var primaryColor: UIColor = UIColor.black
    @IBInspectable var secondaryColor: UIColor = UIColor.gray
}

final class UserViewFullNameIBPresenter : UserViewIBPresenter {
    
    override func presenter() -> Any? {
        return UserViewFullNamePresenter(primaryColor: primaryColor, secondaryColor: secondaryColor)
    }
}

final class UserViewNameIBPresenter : UserViewIBPresenter {
    
    override func presenter() -> Any? {
        return UserViewNamePresenter(primaryColor: primaryColor, secondaryColor: secondaryColor)
    }
}
