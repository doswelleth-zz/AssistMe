//
//  FocusNoteDetailCell.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class FocusNoteDetailCell: UICollectionViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.textColor = .black
        textView.tintColor = .black
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isUserInteractionEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.textContainer.maximumNumberOfLines = 9
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews() {
        backgroundColor = .white
        addSubview(dateLabel)
        addSubview(noteTextView)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        
        dateLabel.text = formatter.string(from: date)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        noteTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noteTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
