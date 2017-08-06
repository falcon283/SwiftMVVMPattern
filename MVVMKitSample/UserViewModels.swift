//
//  UserViewModels.swift
//  MVVMKit
//
//  Created by FaLcON2 on 02/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import Foundation
import MVVMKit

struct UserViewModel : ViewModel {
    
    enum Gender : String {
        case male
        case female
    }
    
    var name: String = "Name"
    var surname: String = "Surname"
    var gender: Gender = .male
}

struct UsersViewModel : ViewModel {
    private(set) var users: [UserViewModel]
    
    init(users: [UserViewModel]) {
        self.users = users
    }
}
