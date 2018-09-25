//
//  FocusTableViewController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "reuseIdentifier"

class FocusTableViewController: UITableViewController {
    
    let focusController = FocusController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = "Focus Log"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(FocusCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        
        setUpNavBar()
        
        focusController.encode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        focusController.encode()
    }
    
    func setUpNavBar() {
        
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "Create"), for: .normal)
        right.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTap(sender:)), for: .touchUpInside)
        
        let left = UIButton(type: .custom)
        left.setImage(UIImage(named: "Notes"), for: .normal)
        left.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        left.contentMode = .scaleAspectFill
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
        navigationController?.hidesBarsOnTap = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func rightBarButtonTap(sender: UIButton) {
        createFocus()
    }
    
    @objc func leftBarButtonTap(sender: UIButton) {
        createNotes()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionLabel: UILabel = {
            let label = UILabel()
            label.text = "Monday"
            return label
        }()
        return sectionLabel.text
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusController.foci.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FocusCell
        
        let focus = focusController.foci[indexPath.row]
        cell.textLabel?.text = focus.sessionDay
        cell.detailTextLabel?.text = focus.sessionDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let focus = focusController.foci[indexPath.row]
            focusController.delete(focus: focus)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // TODO : Pass Data Programmatically
    
    func createFocus() {
        let vc = FocusDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createNotes() {
        let vc = FocusNoteViewController()
        vc.noteController = noteController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    let noteController = NoteController()
}
