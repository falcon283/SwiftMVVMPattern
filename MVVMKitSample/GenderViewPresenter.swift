//
//  GenderViewPresenter.swift
//  MVVMKit
//
//  Created by FaLcON2 on 05/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import SwiftMVVMPattern

final class GenderViewPresenter : Presenter<GenderView, UserViewModel> {
    override func update(view: GenderView, with viewModel: UserViewModel) {
        view.imageView?.image = viewModel.gender.genderViewPresenterImage
    }
}

final class IBGenderViewPresenter : AnyPresenter {
    override func presenter() -> Any? {
        return GenderViewPresenter()
    }
}

extension UserViewModel.Gender {
    
    var genderViewPresenterImage: UIImage {
        switch self {
        case .male:
            return #imageLiteral(resourceName: "male")
        case .female:
            return #imageLiteral(resourceName: "female")
        }
    }
}
