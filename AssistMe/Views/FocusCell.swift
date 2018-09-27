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
        label.textColor = .black
        label.textAlignment = .center
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
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.tintColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func setNeedsUpdateConstraints() {
        super.setNeedsUpdateConstraints()
        
        setUpViews()
    }

    private func setUpViews() {
        backgroundColor = .white
        addSubview(dateLabel)
        addSubview(sessionDayTextField)
        addSubview(descriptionTextView)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        dateLabel.text = formatter.string(from: date)
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sessionDayTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        sessionDayTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 14).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
