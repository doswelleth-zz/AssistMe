//
//  NoteController.swift
//  AssistMe
//
//  Created by David Doswell on 9/25/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private var notePList = "notePList"

class NoteController {
    
    private(set) var notes: [Note] = []
    
    func createNote(with date: Date, note: String) {
        let note = Note(date: date, note: note)
        notes.append(note)
        encode()
    }
    
    func update(note: Note) {
        guard let index = notes.index(of: note) else { return }
        notes.remove(at: index)
        notes.append(note)
        encode()
    }
    
    func delete(note: Note) {
        guard let index = notes.index(of: note) else { return }
        notes.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(notePList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let notesData = try encoder.encode(notes)
            try notesData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let notesData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedNotes = try decoder.decode([Note].self, from: notesData)
            notes = decodedNotes
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
