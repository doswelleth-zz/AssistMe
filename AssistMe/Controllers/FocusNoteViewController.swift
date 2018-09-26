//
//  FocusNoteViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = "Notes"

class FocusNoteViewController: UIViewController {
    
    let focusNoteDetailCell = FocusNoteDetailCell()
    var noteController: NoteController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.noteController?.decode()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let notesVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        notesVC.backgroundColor = .white
        notesVC.alwaysBounceVertical = true
        notesVC.showsVerticalScrollIndicator = false
        return notesVC
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
        collectionView.register(FocusNoteDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setUpNavBar() {
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "Create"), for: .normal)
        right.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
    }
    
    @objc private func rightBarButtonTap(sender: UIButton) {
        let vc = FocusNoteDetailController()
        vc.noteController = noteController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FocusNoteViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return noteController?.notes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FocusNoteDetailCell
        
        let note = noteController?.notes[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.dateLabel.text = formatter.string(from: note?.date ?? Date())
        cell.noteTextView.text = note?.note
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete this note?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            let note = self.noteController?.notes[indexPath.row]
            self.noteController?.delete(note: note!)
            
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

extension FocusNoteViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30.0
    }
}
