//
//  ProfileViewController.swift
//  pr1
//
//  Created by Никита Попов on 15.02.24.
//

import UIKit

final class ProfileViewController: UIViewController {
    var delegate: UpdateStyleDelegate?
    private let nwm = NetworkManager()
    var currentUserInfo: ProfileInfo?
    private var nameLabel = UILabel()
    private var profileImage = UIImageView()
    private var buttonStack = UIStackView()
    private var isContactProfile: Bool
    
    private let buttonDark = UIButton()
    private let buttonLight = UIButton()
    private let buttonSky = UIButton()
    
    private var sc = UISegmentedControl()
    
    init(isContactProfile: Bool){
        self.isContactProfile = isContactProfile
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createImageView()
        createNameLabel()
        //createStack()
        if !isContactProfile{
            createSC()
        }
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = CurrentSheme.shared.sh.bkColor

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
    
    private func updateStyleButtons() {
        for butt in [buttonDark, buttonLight, buttonSky]{
            butt.tintColor = CurrentSheme.shared.sh.textColor
            butt.backgroundColor = CurrentSheme.shared.sh.bkColor
            butt.layer.cornerRadius = 20
            butt.layer.borderColor = UIColor.red.cgColor
            butt.layer.borderWidth = 1
        }
    }
    
    private func createSC(){
        sc = UISegmentedControl(items: ShemeStyle.allCases.map{$0.rawValue})
        view.addSubview(sc)
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sc.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            sc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sc.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        sc.addTarget(self, action: #selector(segmContr), for: .valueChanged)
    }
    
    private func blackSh(){
        CurrentSheme.shared.sh = .dark
        updateStyleButtons()
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        delegate?.updateStyle()
    }
    private func lightSh(){
        CurrentSheme.shared.sh = .light
        updateStyleButtons()
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        delegate?.updateStyle()
    }
    private func skySh(){
        CurrentSheme.shared.sh = .sky
        updateStyleButtons()
        view.backgroundColor = CurrentSheme.shared.sh.bkColor
        delegate?.updateStyle()
    }
    
    @objc func segmContr(){
        let select = sc.selectedSegmentIndex
        let titleSC = sc.titleForSegment(at: select)
        switch titleSC{
        case "Dark":
            blackSh()
        case "Light":
            lightSh()
        case "Sky":
            skySh()
        default:
            print("DEBUG : - No Result select")
        }
    }

}
