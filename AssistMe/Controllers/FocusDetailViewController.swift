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
    
    var focusController: FocusController?
        
    let sessionDayTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Session Day"
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Focus Description"
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 20)
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
    
    @objc func createButtonTap(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create a Focus"
        navigationController?.hidesBarsOnTap = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpViews()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(sessionDayTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(createButton)
        
        sessionDayTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        sessionDayTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextField.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 30).isActive = true
        descriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        createButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 40).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
