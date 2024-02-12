//
//  PhotosCollectionViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

private let reuseIdentifier = "Cell"

final class PhotosCollectionViewController: UICollectionViewController {
    private var imagePers:[UIImage] = []
    private var nw = NetworkManager()
    var currentUser:CurrentUser?
    
    
    override func loadView() {
        super.loadView()
        addLayout()
        nw.getDataRickAndMorty(arrPers: nw.getArrPersID(6)) { [ weak self ] res in
            guard let res = res else { return }
            res.map{
                self?.nw.loadImage($0.image) { im in
                    self?.imagePers.append(im)
                    DispatchQueue.main.async{
                        self?.collectionView.reloadData()
                    }
                }
            }
            
        }
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
                for ph in res.response.items{
                    print(ph.sizes.first?.url ?? "no url")
                }
            }
        }else {
            print("no current user")
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
        return imagePers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? PrototypeCollectionViewCell else { return UICollectionViewCell()}
        let currentImage = imagePers[indexPath.item]
        DispatchQueue.main.async{
            cell.setContent(currentImage)
        }
        
        return cell
    }
    
    
}
