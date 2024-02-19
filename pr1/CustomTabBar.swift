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
        let fr = FriendsTableViewController()
        fr.currentUser = currentUser
        let friendsVC = UINavigationController(rootViewController: fr)
        
        let gr = GroupsTableVCTableViewController()
        gr.currentUser = currentUser
        let groupsVC = UINavigationController(rootViewController: gr)
        
        let photo = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
            nw.getCurrentProfileInfo(currentUser.token, currentUser.id) { [weak self] info in
                self?.currentInfoItem = info
                self?.nw.loadImage(info.response.photo200) {image in
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
        let vc = ProfileViewController()
        vc.currentUserInfo = self.currentInfoItem
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
}
