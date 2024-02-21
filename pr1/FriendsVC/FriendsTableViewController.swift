//
//  FriendsTableViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    private var rc = UIRefreshControl()
    private var data: [RickNetwModel] = []
    private let nw = NetworkManager()

    
    private var friendsArr: [FriendPersonModel] = []{
        didSet{
            for item in friendsArr{
                DispatchQueue.main.async {
                    DataManager.shared.deleteItemFriend()
                }
                DispatchQueue.main.async {
                    DataManager.shared.saveDataFriends(name: "\(item.firstName) \(item.lastName)")
                }
            }
        }
    }
    private var friendsData: [FriendDataModel] = []
    var currentUser: CurrentUser?
    private var currentInfoItem: ProfileInfo?
    
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        if let friendsData = DataManager.shared.fetchDataFriends(){
            self.friendsData = friendsData
            print("Произошла загрузка из COREDATA")
            print("выгружено из COREDATA---\(String(describing: friendsData.first?.fullName))")
            print("Происходит загрузка из сети")
            loadFriendsVK()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rc.addTarget(self, action: #selector(refreshable), for: .valueChanged)
        tableView.register(FriendsCellPrototype.self, forCellReuseIdentifier: "cellPrototype")
        self.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        updateColorSh()
        tableView.addSubview(rc)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateColorSh()
    }
    
    private func loadFriendsVK() {
        if let currentUser = currentUser{
            nw.getContact(currentUser.token , currentUser.id) { [weak self] res, err in
                if let err = err {
                    let ac = UIAlertController(title: "Error load data", message: "\(err.localizedDescription)", preferredStyle: .alert)
                    let acAction = UIAlertAction(title: "OK", style: .default){_ in 
                        let ac2 = UIAlertController(title: "Error load data", message: "Возможна устаревшая информация", preferredStyle: .alert)
                        let acAction2 = UIAlertAction(title: "OK", style: .default)
                        ac2.addAction(acAction2)
                        self?.present(ac2, animated: true)
                    }
                    ac.addAction(acAction)
                    self?.present(ac, animated: true)
                }else{
                    self?.friendsArr = res.response.items.map{FriendPersonModel($0)}
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        print("Загрузка из сети завершена")
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArr.count == 0 ? friendsData.count : friendsArr.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPrototype", for: indexPath) as? FriendsCellPrototype else { return UITableViewCell()}
        if friendsArr.count == 0{
            let currentPers = friendsData[indexPath.row]
            cell.setContent(image: nil, name: currentPers.fullName ?? "", isOnline: Int(currentPers.isOnline))
        }else{
            let currentPers = friendsArr[indexPath.row]
            nw.loadImage(currentPers.photo100) { [weak cell] image in
                DispatchQueue.main.async {
                    cell?.setContent(image: image, name: "\(currentPers.firstName) \(currentPers.lastName)", isOnline: currentPers.online)
                    cell?.updateStyle()
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if friendsArr.count == 0{
            let currentPers = friendsData[indexPath.row]
            let model = ProfileInfo(response: ResponseProfile(id: Int.random(in: 0...100), homeTown: nil, status: nil, photo200: "", isServiceAccount: false, bdate: nil, verificationStatus: nil, firstName: String(currentPers.fullName?.split(separator: " ")[0] ?? ""), lastName: String(currentPers.fullName?.split(separator: " ")[1] ?? ""), bdateVisibility: 1, phone: nil, relation: nil, sex: nil))
            let vc = ProfileViewController(isContactProfile: true)
            vc.currentUserInfo = model
            present(vc, animated: true)
        }else{
            let currentPers = friendsArr[indexPath.row]
            let model = ProfileInfo(response: ResponseProfile(id: Int.random(in: 0...100), homeTown: nil, status: nil, photo200: currentPers.photo100, isServiceAccount: false, bdate: nil, verificationStatus: nil, firstName: currentPers.firstName, lastName: currentPers.lastName, bdateVisibility: 1, phone: nil, relation: nil, sex: nil))
            let vc = ProfileViewController(isContactProfile: true)
            vc.currentUserInfo = model
            present(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.1
    }
    
    private func updateColorSh(){
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        tableView.backgroundColor = CurrentSheme.shared.sh.bkColor
        tableView.reloadData()
    }
    
    @objc func refreshable(){
        loadFriendsVK()
        rc.endRefreshing()
    }
}

extension FriendsTableViewController: UpdateStyleDelegate{
    func updateStyle() {
        self.updateColorSh()
    }
}
