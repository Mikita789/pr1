//
//  PrototypeCollectionViewCell.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

final class PrototypeCollectionViewCell: UICollectionViewCell {
    private var photoView = UIImageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        createPhoto()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(_ image: UIImage?){
        photoView.image = image
    }
    
    private func createPhoto(){
        contentView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true
        photoView.layer.shadowRadius = 5
        photoView.layer.cornerRadius = 10
        photoView.layer.shadowColor = UIColor.red.cgColor
    }
    
    
}
