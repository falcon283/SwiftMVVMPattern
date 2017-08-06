//
//  UserView.swift
//  MVVMKit
//
//  Created by FaLcON2 on 02/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import SwiftMVVMPattern

class UserView : UIView {
    @IBOutlet weak var label: UILabel?
}

extension UserView : View { }
