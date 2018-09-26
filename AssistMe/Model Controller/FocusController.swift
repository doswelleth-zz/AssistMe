//
//  FocusController.swift
//  AssistMe
//
//  Created by David Doswell on 9/24/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private var focusPList = "focusPList"

class FocusController {
    
    private(set) var foci: [Focus] = []
    
    func createFocus(with sessionDay: String, sessionDescription: String, sessionDate: Date) {
        let focus = Focus(sessionDay: sessionDay, sessionDescription: sessionDescription, sessionDate: sessionDate)
        foci.append(focus)
        encode()
    }
    
    func update(focus: Focus) {
        guard let index = foci.index(of: focus) else { return }
        foci.remove(at: index)
        foci.append(focus)
        encode()
    }
    
    func delete(focus: Focus) {
        guard let index = foci.index(of: focus) else { return }
        foci.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(focusPList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let fociData = try encoder.encode(foci)
            try fociData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let fociData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedFoci = try decoder.decode([Focus].self, from: fociData)
            foci = decodedFoci
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
