//
//  FocusViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AudioToolbox

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = "Focus"

class FocusViewController: UIViewController {
        
    let focusController = FocusController()    
    var sortedFoci: [Focus] = []
    var focusCell: FocusCell?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.sortedFoci = self.focusController.foci.sorted(by: {$0.sessionDate > $1.sessionDate})
            self.focusController.decode()
            self.collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let focusVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        focusVC.backgroundColor = .white
        focusVC.alwaysBounceVertical = true
        focusVC.showsVerticalScrollIndicator = false
        return focusVC
    }()
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpNavBar()
        
        self.title = navigationTitle
        
        DispatchQueue.main.async {
            self.sortedFoci = self.focusController.foci.sorted(by: {$0.sessionDate > $1.sessionDate})
            self.focusController.decode()
            self.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FocusCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        createAFocus()
    }
    
    func setUpNavBar() {
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "Wheel"), for: .normal)
        right.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func rightBarButtonTap(sender: UIButton) {
        let vc = FocusDetailViewController()
        vc.focusController = focusController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func createAFocus() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(createFocusFunction), name: Notification.Name(rawValue: String.notificationName), object: nil)
    }
    
    @objc private func createFocusFunction() {
        let _ = AudioServicesPlaySystemSound(1519)
        focusCell?.startTimer()
        focusCell?.zeroColorWheel.image = focusCell?.firstColorWheel.image
    }
}

extension FocusViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedFoci.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FocusCell
        
        let focus = sortedFoci[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.dateLabel.text = formatter.string(from: focus.sessionDate)
        cell.sessionDayTextField.text = focus.sessionDay
        cell.descriptionTextView.text = focus.sessionDescription
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let focus = sortedFoci[indexPath.item]
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete this note?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            DispatchQueue.main.async {
                self.focusController.delete(focus: focus)
                self.sortedFoci = self.focusController.foci.sorted(by: { $0.sessionDate > $1.sessionDate })
                
                self.collectionView.reloadData()
            }
        }
        let no = UIAlertAction(title: "No", style: .default) { (action) in
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension FocusViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30.0
    }
}
