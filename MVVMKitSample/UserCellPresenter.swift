//
//  UserCellPresenter.swift
//  MVVMKit
//
//  Created by FaLcON2 on 02/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import MVVMKit

class UserCellFullNamePresenter : Presenter<UserCell, UserViewModel> {
    
    override func update(view: UserCell, with viewModel: UserViewModel) {
        view.nameLabel?.text = viewModel.name
        view.nameLabel?.textColor = UIColor.blue
        view.surnameLabel?.text = viewModel.surname
        view.surnameLabel?.textColor = UIColor.red
    }
}

class UserCellNamePresenter : Presenter<UserCell, UserViewModel> {
    
    override func update(view: UserCell, with viewModel: UserViewModel) {
        view.nameLabel?.text = "\(viewModel.name) \(viewModel.surname)"
        view.nameLabel?.textColor = UIColor.green
    }
}

class GenderFullNamePresenter : Presenter<UserCell, UserViewModel> {
    
    override func update(view: UserCell, with viewModel: UserViewModel) {
        view.nameLabel?.text = viewModel.name
        view.surnameLabel?.text = viewModel.surname
        view.contentView.backgroundColor = viewModel.gender.genderCellColor
    }
}

extension UserViewModel.Gender {
    
    var genderCellColor: UIColor {
        switch self {
        case .female:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .male:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
}
