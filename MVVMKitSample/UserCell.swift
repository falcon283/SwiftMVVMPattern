//
//  UserCell.swift
//  MVVMKit
//
//  Created by FaLcON2 on 02/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import SwiftMVVMPattern

class UserCell : UITableViewCell, Contextable, Presentable {
    
    var context: Any?
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var surnameLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        context = nil
        nameLabel?.text = nil
        surnameLabel?.text = nil
    }
    
    var presenter: Presenter<UserCell, UserViewModel>? {
        didSet {
            
            guard let viewModel = context as? UserViewModel else {
                return
            }
            
            presenter?.update(view: self, with: viewModel)
        }
    }
}

extension UserCell : View { }
