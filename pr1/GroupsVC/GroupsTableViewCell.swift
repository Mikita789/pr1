//
//  GroupsTableViewCell.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    private var groupIcon = UIImageView()
    private var groupTitle = UILabel()
    private var groupDescription = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        createIcon()
        createGroupTitle()
        createDescrLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(image: UIImage?, title: String, descr: String){
        groupIcon.image = image
        groupTitle.text = title
        groupDescription.text = descr
        calculateFrameImage()
    }
    
    private func createIcon(){
        contentView.addSubview(groupIcon)
        
        groupIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            groupIcon.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            groupIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func calculateFrameImage(){
        groupIcon.layer.cornerRadius = groupIcon.bounds.height / 2
        groupIcon.contentMode = .scaleAspectFill
        groupIcon.clipsToBounds = true
    }
    
    private func createGroupTitle(){
        contentView.addSubview(groupTitle)
        
        groupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupTitle.leadingAnchor.constraint(equalTo: groupIcon.trailingAnchor, constant: 10),
            groupTitle.topAnchor.constraint(equalTo: groupIcon.topAnchor),
            groupTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            groupTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        groupTitle.font = CurrentSheme.shared.sh.font
        groupTitle.textColor = CurrentSheme.shared.sh.textColor
        groupTitle.backgroundColor = .clear
        groupTitle.textAlignment = .left
        groupTitle.numberOfLines = 1
    }
    
    private func createDescrLabel(){
        contentView.addSubview(groupDescription)
        
        groupDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupDescription.topAnchor.constraint(equalTo: groupTitle.bottomAnchor, constant: 5),
            groupDescription.leadingAnchor.constraint(equalTo: groupTitle.leadingAnchor),
            groupDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            groupDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        groupDescription.font = CurrentSheme.shared.sh.font
        groupDescription.textColor = CurrentSheme.shared.sh.textColor
        groupDescription.backgroundColor = .clear
        groupDescription.textAlignment = .left
        groupDescription.numberOfLines = 1
    }
    
    func updateStyle(){
        groupTitle.font = CurrentSheme.shared.sh.font
        groupTitle.textColor = CurrentSheme.shared.sh.textColor
        groupDescription.font = CurrentSheme.shared.sh.font
        groupDescription.textColor = CurrentSheme.shared.sh.textColor
    }
}
