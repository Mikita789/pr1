//
//  FriendsTableViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    var data: [RickNetwModel] = []
    let nw = NetworkManager()
    
    var friendsArr: [FriendPersonModel] = []
    var currentUser: CurrentUser?
    
    override func loadView() {
        super.loadView()
        if let currentUser = currentUser{
            self.nw.getContact(currentUser.token , currentUser.id) { [weak self] res in
                self?.friendsArr = res.response.items.map{FriendPersonModel($0)}
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsCellPrototype.self, forCellReuseIdentifier: "cellPrototype")
        self.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        printAllContacts()
    }
    
    
    //MARK: - all contacts in console
    private func printAllContacts(){
        if let currentUser = currentUser{
            nw.getContact(currentUser.token, currentUser.id){res in
                for fr in res.response.items{
                    print("FullName: \(fr.firstName)  \(fr.lastName)")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArr.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPrototype", for: indexPath) as? FriendsCellPrototype else { return UITableViewCell()}
        
        let currentPers = friendsArr[indexPath.row]
        self.nw.loadImage(currentPers.photo100) { [weak self] image in
            DispatchQueue.main.async {
                cell.setContent(image: image, name: "\(currentPers.firstName) \(currentPers.lastName)", isOnline: currentPers.online)
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.1
    }
}
