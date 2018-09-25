//
//  FocusNoteDetailController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import CoreData

private let navigationTitle = "Create a Note"


class FocusNoteDetailController: UIViewController, UITextFieldDelegate {
    
    let note: Note? = nil
    var noteController: NoteController?
    
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
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = false
        textView.textContainer.maximumNumberOfLines = 9
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(createButtonTap), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    @objc private func createButtonTap(sender: UIButton) {
        if let note = note {
            noteController?.update(note: note)
        } else if note == nil {
            guard let note = noteTextView.text else { return }
            noteController?.createNote(with: Date(), note: note)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func textViewDidBeginEditing(_ noteTextView: UITextView) {
        if noteTextView.textColor == .lightGray {
            noteTextView.text = nil
            noteTextView.textColor = .black
        }
    }
    
    private func textViewDidEndEditing(_ noteTextView: UITextView) {
        if noteTextView.text.isEmpty {
            noteTextView.text = "Notes"
            noteTextView.textColor = .lightGray
        }
    }
    
    private func setUpViews() {
        
        view.backgroundColor = .white
        
        self.title = navigationTitle
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: date)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(dateLabel)
        view.addSubview(noteTextView)
        view.addSubview(createButton)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        noteTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        noteTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noteTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        createButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 100).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
