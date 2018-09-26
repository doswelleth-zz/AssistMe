//
//  FocusViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = "Focus"

class FocusViewController: UIViewController {
        
    let focusController = FocusController()
    let noteController = NoteController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.focusController.decode()
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FocusCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setImage(UIImage(named: "Notes"), for: .normal)
        left.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        left.contentMode = .scaleAspectFill
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
        
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "Create"), for: .normal)
        right.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
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
    
    @objc private func leftBarButtonTap(sender: UIButton) {
        let vc = FocusNoteViewController()
        vc.noteController = noteController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FocusViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return focusController.foci.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FocusCell
        
        let focus = focusController.foci[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.dateLabel.text = formatter.string(from: focus.sessionDate)
        cell.sessionDayTextField.text = focus.sessionDay
        cell.descriptionTextField.text = focus.sessionDescription
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete this note?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            let focus = self.focusController.foci[indexPath.row]
            self.focusController.delete(focus: focus)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        let no = UIAlertAction(title: "No", style: .default) { (action) in }
        
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
        
        return CGSize(width: 300, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30.0
    }
}
