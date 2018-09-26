//
//  FocusDetailViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import CoreData

class FocusDetailViewController: UIViewController {
    
    let focus: Focus? = nil
    var focusController: FocusController?
    
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
        textField.textAlignment = .left
        textField.placeholder = "Session Day"
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Focus Description"
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        // number of lines
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(createButtonTap(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func createButtonTap(sender: UIButton) {
        
        if sessionDayTextField.text!.isEmpty || descriptionTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please create a focus", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let sessionDay = sessionDayTextField.text, let description = descriptionTextField.text else { return }
            focusController?.createFocus(with: sessionDay, sessionDescription: description, sessionDate: Date())
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create a Focus"
        navigationController?.hidesBarsOnTap = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: date)
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(dateLabel)
        view.addSubview(sessionDayTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(createButton)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sessionDayTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        sessionDayTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        createButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 40).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
