//
//  FullNameUsersViewController.swift
//  MVVMKit
//
//  Created by FaLcON2 on 05/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import SwiftMVVMPattern

final class FullNameUsersViewController : UsersViewController, Presentable {
    
    var presenter: Presenter<UserCell, UserViewModel>? = GenderFullNamePresenter()
    
    @IBAction func unwindToPresentableTableView(segue: UIStoryboardSegue) { }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("No Valid Cell")
        }
        
        let cellViewModel = viewModel?.users[indexPath.row]
        
        if let cellViewModel = cellViewModel {
            cell.context = cellViewModel
            presenter?.update(view: cell, with: cellViewModel)
        }
        
        return cell
    }
}
