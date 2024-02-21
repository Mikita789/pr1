//
//  SettingsViewController.swift
//  pr1
//
//  Created by Никита Попов on 19.02.24.
//

import UIKit

class SettingsViewController: UIViewController {
    var buttonBlack: UIButton = UIButton()
    var buttonWhite: UIButton = UIButton()
    var buttonGray: UIButton = UIButton()
    var stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func createStack(){
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        stack.layer.borderWidth = 1
        buttonBlack.setTitle("Black", for: .normal)
        buttonBlack.backgroundColor = .black
        buttonBlack.tintColor = .white
        buttonBlack.addTarget(self, action: #selector(blackSh), for: .touchUpInside)
        buttonWhite.addTarget(self, action: #selector(whiteSh), for: .touchUpInside)
        buttonWhite.setTitle("White", for: .normal)
        buttonWhite.tintColor = .black
        buttonWhite.backgroundColor = .black
        buttonGray.addTarget(self, action: #selector(graySh), for: .touchUpInside)
        buttonGray.setTitle("Gray", for: .normal)
        buttonGray.tintColor = .red
        buttonGray.backgroundColor = .green
        stack.addArrangedSubview(buttonBlack)
        stack.addArrangedSubview(buttonWhite)
        stack.addArrangedSubview(buttonGray)
    }
    
    @objc func blackSh(){
        CurrentSheme.shared.sh = .dark
    }
    @objc func whiteSh(){
        CurrentSheme.shared.sh = .light
    }
    @objc func graySh(){
        CurrentSheme.shared.sh = .sky
    }
}
