//
//  ProfileViewController.swift
//  pr1
//
//  Created by Никита Попов on 15.02.24.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let nwm = NetworkManager()
    var currentUserInfo: ProfileInfo?
    private var nameLabel = UILabel()
    private var profileImage = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createImageView()
        createNameLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculateFrame()
    }
    
    private func calculateFrame() {
        if let currentUserInfo = currentUserInfo{
            nwm.loadImage(currentUserInfo.response.photo200) {[weak self] image in
                
                
                DispatchQueue.main.async {
                    let sizes = image.size
                    self?.profileImage.frame = CGRect(x: 0,
                                                      y: 40,
                                                      width: sizes.width, height: sizes.height)
                    self?.profileImage.center.x = self?.view.center.x ?? 0
                    self?.profileImage.image = image
                    self?.profileImage.clipsToBounds = true
                    self?.profileImage.layer.cornerRadius = 30
                }
            }
        }
    }
    
    private func createImageView(){
        view.addSubview(profileImage)
        profileImage.contentMode = .scaleAspectFit
        calculateFrame()
    }
    
    private func createNameLabel(){
        profileImage.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        nameLabel.textAlignment = .center
        nameLabel.text = "\(currentUserInfo?.response.firstName ?? "") \(currentUserInfo?.response.lastName ?? "")"
        nameLabel.textColor = .white
        nameLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        nameLabel.textAlignment = .center
    }

}
