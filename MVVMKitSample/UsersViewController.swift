//
//  UsersViewController.swift
//  MVVMKit
//
//  Created by FaLcON2 on 01/08/2017.
//  Copyright © 2017 Gabriele Trabucco. All rights reserved.
//

import UIKit
import SwiftMVVMPattern

class UsersViewController : UITableViewController, ViewModelHolder {
    
    let viewModel: UsersViewModel? = UsersViewModel(users: [UserViewModel(name: "name1", surname: "surname1", gender: .male),
                                                            UserViewModel(name: "name2", surname: "surname2", gender: .male),
                                                            UserViewModel(name: "name3", surname: "surname3", gender: .male),
                                                            UserViewModel(name: "name4", surname: "surname4", gender: .female),
                                                            UserViewModel(name: "name5", surname: "surname5", gender: .female),
                                                            UserViewModel(name: "name6", surname: "surname6", gender: .male),
                                                            UserViewModel(name: "name7", surname: "surname7", gender: .male),
                                                            UserViewModel(name: "name8", surname: "surname8", gender: .female),
                                                            UserViewModel(name: "name9", surname: "surname9", gender: .female)])
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let cell = sender as? UserCell,
            let vm = cell.context as? UserViewModel,
            let vc = segue.destination as? UserVCProtocol else {
            return
        }
        
        vc.viewModel = vm
    }
    
    @IBAction func unwindToTableView(segue: UIStoryboardSegue) { }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.users.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("No Valid Cell")
        }
        
        cell.context = viewModel?.users[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.presenter = UserCellFullNamePresenter()
        }
        else {
            cell.presenter = UserCellNamePresenter()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // The cell context usage increase the consistency of data retrieval.
        // DataSource can change while the user is still able to interact
        // with the tableView while it is about to be reloaded. 
        // Remember that reloading the full TableView is an asynchronous process
        // and reloading data invalidate the table but the views can still be visible.
        // This happen for example when you have lots of updates behind the scene 
        // for example an High refresh rate Real Time Table View.
        
        // In a functional environment (RxSwift, ReactiveCocoa) you achieve the 
        // same result retaining the data inside the injected function 
        // untill the cell get invalidated.
        
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell,
            let vm = cell.context as? UserViewModel else {
            return
        }
        
        print("\(vm.name)")
    }
}
