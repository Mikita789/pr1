//
//  GroupsTableVCTableViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class GroupsTableVCTableViewController: UITableViewController {
    var currentUser: CurrentUser?
    private var nw = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: "groupsCell")
        self.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        printAllGroups()
    }
    
    //MARK: - print all groups
    private func printAllGroups(){
        if let currentUser = currentUser{
            nw.getAllGroups(currentUser.token, currentUser.id) { res in
                for gr in res.response.items{
                    print("\(gr.name)")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsTableViewCell else { return UITableViewCell()}
        
        cell.setContent(image: UIImage(systemName: "person"), title: "Some Title", descr: "Long text")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.1
    }
}
