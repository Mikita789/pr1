//
//  TableViewCellPrototype.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class FriendsCellPrototype: UITableViewCell {
    
    private var avatar = UIImageView()
    private var nameLabel = UILabel()
    private var isOnlineLabel = UIView()
    var isOnline : Bool?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        createAvatar()
        addIsOnlineLabel()
        createNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(image: UIImage?, name: String, isOnline: Int){
        self.isOnline = isOnline == 1 ? true : false
        nameLabel.text = name
        avatar.image = image
        calculateFrameImage()
        calculateStatusLabelFrame()
    }
    
    private func createAvatar(){
        contentView.addSubview(avatar)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatar.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            avatar.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    private func calculateFrameImage(){
        avatar.layer.cornerRadius = avatar.bounds.height / 2
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
    }
    
    private func addIsOnlineLabel(){
        contentView.addSubview(isOnlineLabel)
        isOnlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isOnlineLabel.topAnchor.constraint(equalTo: avatar.topAnchor),
            isOnlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isOnlineLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            isOnlineLabel.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func calculateStatusLabelFrame(){
        isOnlineLabel.layer.cornerRadius = isOnlineLabel.bounds.height / 2
        isOnlineLabel.backgroundColor = isOnline == true ? UIColor.systemGreen : UIColor.systemRed
    }
    
    private func createNameLabel(){
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: avatar.topAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            nameLabel.trailingAnchor.constraint(equalTo: isOnlineLabel.leadingAnchor, constant: -5)
        ])
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 1
    }
    
}
