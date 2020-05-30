//
//  GreetingView.swift
//  TodoList
//
//  Created by Вячеслав on 28.05.2020.
//  Copyright © 2020 Вячеслав. All rights reserved.
//

import UIKit

class GreetingView: UIView {

    //MARK: - GUI Properties
    lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, Ivan"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatarIcon")
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
           
    }
    
    //MARK: - Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.addSubview(self.greetingLabel)
        self.addSubview(self.iconImageView)
        self.constraint()
    }

    
    //MARK: - Constraints
    private func constraint() {
        NSLayoutConstraint.activate([
            self.greetingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.greetingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.greetingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.greetingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5)
        ])
        
        NSLayoutConstraint.activate([
            self.iconImageView.bottomAnchor.constraint(equalTo: self.greetingLabel.topAnchor, constant: -16),
            self.iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 64),
            self.iconImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -64),
            self.iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor, multiplier: 1)
        ])
    }
    
}
