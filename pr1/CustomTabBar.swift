//
//  CustomTabBar.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class CustomTabBar: UITabBarController {
    var currentUser: CurrentUser?

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
        
        print("\(VKEndPoints.getContacts.getURL(token: "YOUR_TOKKEN", id: "YOUR_ID")) FOR CONTACTS")
        print("\(VKEndPoints.getGroups.getURL(token: "YOUR_TOKKEN", id: "YOUR_ID")) FOR GROUPS")
        print("\(VKEndPoints.getPhotos.getURL(token: "YOUR_TOKKEN", id: "YOUR_ID")) FOR PHOTOS")
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
        
        self.viewControllers = [friendsVC, groupsVC, photosVC]
    }
    
    private func setStyleTabBar(){
        let currentColorSh = UITraitCollection.current.userInterfaceStyle
        tabBar.tintColor = currentColorSh == .light ? .black : .white
    }
    
}
