//
//  FocusCell.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class FocusCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sessionDayTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "Session Day"
        textField.tintColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Focus Description"
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func setNeedsUpdateConstraints() {
        super.setNeedsUpdateConstraints()
        
        setUpViews()
    }

    private func setUpViews() {
        backgroundColor = .white
        addSubview(dateLabel)
        addSubview(sessionDayTextField)
        addSubview(descriptionTextField)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        
        dateLabel.text = formatter.string(from: date)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sessionDayTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        sessionDayTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
