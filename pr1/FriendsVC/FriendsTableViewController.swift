//
//  FriendsTableViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    private var data: [RickNetwModel] = []
    private let nw = NetworkManager()
    
    private var friendsArr: [FriendPersonModel] = []
    var currentUser: CurrentUser?
    private var currentInfoItem: ProfileInfo?
    
    override func loadView() {
        super.loadView()
        if let currentUser = currentUser{
            nw.getContact(currentUser.token , currentUser.id) { [weak self] res in
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
        addProfileButton()
    }
    
    //MARK: - add button profile to navigation bar
    
    private func addProfileButton(){
        if let currentUser = currentUser{
            nw.getCurrentProfileInfo(currentUser.token, currentUser.id) { [weak self] info in
                self?.currentInfoItem = info
                self?.nw.loadImage(info.response.photo200) { image in
                    DispatchQueue.main.async{
                        let image = self?.resizeImage(image: image, targetSize: CGSize(width: 40, height: 40))
                        let button = UIButton(type: .custom)
                        button.clipsToBounds = true
                        button.contentMode = .scaleAspectFit
                        button.layer.cornerRadius = 40 / 2
                        button.setBackgroundImage(image, for: .normal)
                        button.addTarget(self, action: #selector(self?.pushToProfile), for: .touchUpInside)
                        self?.navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: button)
                    }
                }
            }
        }else{
            let navBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pushToProfile))
            navBarItem.tintColor = .black
            navigationItem.rightBarButtonItem = navBarItem
        }
    }
    // MARK: - Set Image size
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
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
        nw.loadImage(currentPers.photo100) { [weak cell] image in
            DispatchQueue.main.async {
                cell?.setContent(image: image, name: "\(currentPers.firstName) \(currentPers.lastName)", isOnline: currentPers.online)
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.1
    }
    
    @objc func pushToProfile(){
        let vc = ProfileViewController()
        vc.currentUserInfo = self.currentInfoItem
        
        self.present(vc, animated: true)
    }
}
