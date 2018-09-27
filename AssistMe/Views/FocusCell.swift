//
//  FocusCell.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AudioToolbox

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
    
    let date = Date()
    let formatter = DateFormatter()
    
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
    
    let zeroColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Zero")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let firstColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "First")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let secondColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Second")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let thirdColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Third")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let fourthColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Fourth")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let fifthColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Fifth")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let sixthColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Sixth")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let seventhColorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Seventh")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let colorWheel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Wheel")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    var countdownTimer: Timer!
    var totalTime = 3600
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
            updateColorWheel()
        } else {
            endTimer()
        }
    }
    
    func updateColorWheel() {
        switch totalTime {
        case 2999:
            firstColorWheel.image = secondColorWheel.image
            let _ = AudioServicesPlaySystemSound(1027)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case 2399:
            firstColorWheel.image = thirdColorWheel.image
            let _ = AudioServicesPlaySystemSound(1032)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case 1799:
            firstColorWheel.image = fourthColorWheel.image
            let _ = AudioServicesPlaySystemSound(1023)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case 1199:
            firstColorWheel.image = fifthColorWheel.image
            let _ = AudioServicesPlaySystemSound(1022)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case 599:
            firstColorWheel.image = sixthColorWheel.image
            let _ = AudioServicesPlaySystemSound(1030)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        case 0:
            firstColorWheel.image = seventhColorWheel.image
            let _ = AudioServicesPlaySystemSound(1028)
            let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            endTimer()
        default:
            break
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func createAFocus() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(createFocusFunction), name: Notification.Name(rawValue: String.notificationName), object: nil)
    }
    
    @objc private func createFocusFunction() {
        let _ = AudioServicesPlaySystemSound(1027)
        let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        startTimer()
    }
    
    private func setUpViews() {
        backgroundColor = .white
        addSubview(dateLabel)
        addSubview(sessionDayTextField)
        addSubview(firstColorWheel)
        addSubview(timerLabel)
        addSubview(descriptionTextView)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: date)
        
        createAFocus()
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sessionDayTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        sessionDayTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 14).isActive = true
        sessionDayTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sessionDayTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        firstColorWheel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
        firstColorWheel.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
        firstColorWheel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        firstColorWheel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        timerLabel.topAnchor.constraint(equalTo: firstColorWheel.bottomAnchor, constant: 50).isActive = true
        timerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: sessionDayTextField.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
