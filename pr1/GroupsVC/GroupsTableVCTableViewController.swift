//
//  GroupsTableVCTableViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class GroupsTableVCTableViewController: UITableViewController {
    private var rc = UIRefreshControl()

    var currentUser: CurrentUser?
    private var nw = NetworkManager()
    private var groupsArr: [ItemGR] = []{
        didSet{
            DispatchQueue.main.async {
                DataManager.shared.deleteItemGroup()
            }
            DispatchQueue.main.async {
                for item in self.groupsArr{
                    DataManager.shared.saveDataGroups(title: item.name, descr: item.description ?? "")
                }
            }
        }
    }
        
    private var allGrFromData: [GroupDataModel] = []
    
    
    override func loadView() {
        super.loadView()
        if let allGrFromData = DataManager.shared.fetchDataGroups(){
            self.allGrFromData = allGrFromData
            print("Произошла загрузка из COREDATA")
            print("выгружено из COREDATA---\(allGrFromData.first?.title ?? "")")
            print("Происходит загрузка из сети")
            getAllGroups()
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: "groupsCell")
        self.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        getAllGroups()
        updateColorSh()
        rc.addTarget(self, action: #selector(refreshable), for: .valueChanged)
        tableView.addSubview(rc)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateColorSh()
    }
    
    //MARK: - print all groups
    private func getAllGroups(){
        if let currentUser = currentUser{
            nw.getAllGroups(currentUser.token, currentUser.id) { [weak self] res, err in
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
                    self?.groupsArr = res.response.items
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
        return groupsArr.count == 0 ? allGrFromData.count : groupsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsTableViewCell else { return UITableViewCell()}
        
        if groupsArr.count == 0{
            let currentItem = allGrFromData[indexPath.row]
            cell.setContent(image: nil, title: currentItem.title ?? "", descr: currentItem.descr ?? "")
        }else{
            let currentItem = groupsArr[indexPath.row]
            nw.loadImage(currentItem.photo100) { [weak cell] image in
                DispatchQueue.main.async {
                    cell?.setContent(image: image , title: currentItem.name, descr: currentItem.description ?? "")
                    cell?.updateStyle()
                }
            }
        }
        return cell
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
        getAllGroups()
        rc.endRefreshing()
    }
}

extension GroupsTableVCTableViewController: UpdateStyleDelegate{
    func updateStyle() {
        self.updateColorSh()
    }
    
    
}
