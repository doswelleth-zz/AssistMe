//
//  FocusDetailViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class FocusDetailViewController: UIViewController, UITextViewDelegate {
    
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
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Focus Description"
        textView.textColor = .lightGray
        textView.textAlignment = .left
        textView.tintColor = .black
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let zeroColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Zero")
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Focus Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
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
        
        if sessionDayTextField.text!.isEmpty || descriptionTextView.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please create a focus", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let sessionDay = sessionDayTextField.text, let description = descriptionTextView.text else { return }
            focusController?.createFocus(with: sessionDay, sessionDescription: description, sessionDate: Date())
            
            createFocusNotification()
            sendNotification()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "NEW FOCUS 🎉"
        content.body = "Let's Goooooo!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Notification ID", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("Error scheduling notification \(error)")
                return
            }
        }
    }
    
    func createFocusNotification() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(rawValue: String.notificationName), object: nil)
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
        
        descriptionTextView.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(dateLabel)
        view.addSubview(sessionDayTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(zeroColorWheel)
        view.addSubview(createButton)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sessionDayTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        sessionDayTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        zeroColorWheel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20).isActive = true
        zeroColorWheel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zeroColorWheel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        zeroColorWheel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        createButton.topAnchor.constraint(equalTo: zeroColorWheel.bottomAnchor, constant: 40).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
