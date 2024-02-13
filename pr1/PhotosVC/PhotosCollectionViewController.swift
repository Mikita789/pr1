//
//  PhotosCollectionViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

private let reuseIdentifier = "Cell"

final class PhotosCollectionViewController: UICollectionViewController {
    private var nw = NetworkManager()
    private var photoURLArr : [String?] = []
    var currentUser:CurrentUser?
    
    
    override func loadView() {
        super.loadView()
        addLayout()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PrototypeCollectionViewCell.self, forCellWithReuseIdentifier: "customCell")
        self.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        printAllPhoto()
    }
    
    
    //MARK: - get all photos
    private func printAllPhoto(){
        if let currentUser = currentUser{
            nw.getAllphotoUser(currentUser.token, currentUser.id) { res in
                for item in res.response.items{
                    let y = item.sizes.filter{$0.type == "x"}
                    self.photoURLArr.append(y.first?.url)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private func addLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = .init(width: view.bounds.width / 2.2 , height: view.bounds.width / 2.2)
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        self.collectionView = collView
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? PrototypeCollectionViewCell else { return UICollectionViewCell()}
        let currentImage = photoURLArr[indexPath.row]
        nw.loadImage(currentImage) { [weak cell] image in
            DispatchQueue.main.async {
                cell?.setContent(image)
            }
        }
        
        return cell
    }
    
    
}
