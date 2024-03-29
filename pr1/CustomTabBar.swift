//
//  CustomTabBar.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class CustomTabBar: UITabBarController {
    var currentUser: CurrentUser?
    private var nw = NetworkManager()
    private var currentInfoItem: ProfileInfo?


    init(currentUser: CurrentUser?){
        self.currentUser = currentUser
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createBaseTabBar()
        setStyleTabBar()
    }
    
    private func createBaseTabBar(){
        let fr = FriendsTableViewController(nwm: nw)
        fr.currentUser = currentUser
        let friendsVC = UINavigationController(rootViewController: fr)
        
        let gr = GroupsTableVCTableViewController(nwm: nw)
        gr.currentUser = currentUser
        let groupsVC = UINavigationController(rootViewController: gr)
        
        let photo = PhotosCollectionViewController(nwm: nw)
        photo.currentUser = currentUser
        let photosVC = UINavigationController(rootViewController: photo)
        
       
        
        let friendsVCItem = UITabBarItem(title: "Friends",
                                         image: UIImage(systemName: "person.crop.circle"),
                                         tag: 0)
        friendsVC.tabBarItem = friendsVCItem
        
        let groupsVCItem = UITabBarItem(title: "Groups",
                                         image: UIImage(systemName: "message"),
                                         tag: 1)
        groupsVC.tabBarItem = groupsVCItem
        
        let photosVCItem = UITabBarItem(title: "Photos",
                                         image: UIImage(systemName: "photo"),
                                         tag: 2)
        photosVC.tabBarItem = photosVCItem
        
        
        
        addProfileButton([friendsVC, groupsVC, photosVC])
        
        self.viewControllers = [friendsVC, groupsVC, photosVC]
    }
    
    private func setStyleTabBar(){
        let currentColorSh = UITraitCollection.current.userInterfaceStyle
        tabBar.tintColor = currentColorSh == .light ? .black : .white
    }
    
    // MARK: - Create profile Button
    private func addProfileButton(_ vcs: [UINavigationController]){
        if let currentUser = currentUser{
            nw.getCurrentProfileInfo(currentUser.token, currentUser.id) { [weak self] res in
                switch res {
                case .success(let success):
                    self?.currentInfoItem = success
                    self?.nw.loadImage(success.response.photo200) {image in
                        DispatchQueue.main.async{
                            let image = self?.resizeImage(image: image, targetSize: CGSize(width: 40, height: 40))
                            let button = UIButton(type: .custom)
                            button.clipsToBounds = true
                            button.contentMode = .scaleAspectFit
                            button.layer.cornerRadius = 40 / 2
                            button.setBackgroundImage(image, for: .normal)
                            button.addTarget(self, action: #selector(self?.pushToProfile), for: .touchUpInside)
                            for vc in vcs{
                                vc.topViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
                            }
                        }
                    }
                case .failure(let failure):
                    let ac = UIAlertController(title: "Error", message: "error Load info", preferredStyle: .alert)
                    let acA = UIAlertAction(title: "OK", style: .default)
                    ac.addAction(acA)
                    self?.present(ac, animated: true)
                }
            }
        }else{
            let navBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pushToProfile))
            navBarItem.tintColor = .black
            navigationItem.rightBarButtonItem = navBarItem
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        addProfileButton(self.viewControllers as? [UINavigationController] ?? [UINavigationController]())
    }
    
    // MARK: - Set Image size
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }
    
    @objc func pushToProfile(){
        let vc = ProfileViewController(isContactProfile: false, nwm: NetworkManager())
        vc.currentUserInfo = self.currentInfoItem
        vc.delegate = self
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
}


extension CustomTabBar: UpdateStyleDelegate{
    func updateStyle() {
        if let viewControllers = viewControllers{
            for vc in viewControllers{
                if let vc = vc as? UpdateStyleDelegate{
                    vc.updateStyle()
                }
            }
        }
    }
}
