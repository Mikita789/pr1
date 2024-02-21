//
//  PhotosCollectionViewController.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import UIKit

private let reuseIdentifier = "Cell"

final class PhotosCollectionViewController: UICollectionViewController {
    var nw: NetwProtocolPhotos
    private var photoURLArr : [String?] = []
    var currentUser:CurrentUser?
    
    init(nwm: NetwProtocolPhotos){
        self.nw = nwm
        super .init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        updateColorSh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateColorSh()
    }
    
    
    //MARK: - get all photos
    private func printAllPhoto(){
        if let currentUser = currentUser{
            nw.getAllphotoUser(currentUser.token, currentUser.id) { res in
                switch res {
                case .success(let success):
                    for item in success.response.items{
                        let y = item.sizes.filter{$0.type == "x"}
                        self.photoURLArr.append(y.first?.url)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let failure):
                    let ac = UIAlertController(title: "Error", message: "Error load image", preferredStyle: .alert)
                    let acA = UIAlertAction(title: "OK", style: .default)
                    ac.addAction(acA)
                    self.present(ac, animated: true)
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
    
    private func updateColorSh(){
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        collectionView.backgroundColor = CurrentSheme.shared.sh.bkColor
    }
    
    
}

extension PhotosCollectionViewController: UpdateStyleDelegate{
    func updateStyle() {
        self.updateColorSh()
    }
    
    
}
