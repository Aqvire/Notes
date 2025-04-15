//
//  ViewController.swift
//  Notes
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var table: UITableView!  // list of notes
    @IBOutlet var label: UILabel!  //

    
    var notes: [(title: String, note: String)] = []  // notes

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Notes"
    }

    
    // New note
    @IBAction func didTapNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.notes.append((title: noteTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false

            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }


    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // number of notes
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // insert titles and notes in a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)             // in tableView
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].note
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // select note
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedNote = notes[indexPath.row]

        
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { //show selected note
            return
        }
        
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = selectedNote.title
        vc.note = selectedNote.note
        navigationController?.pushViewController(vc, animated: true)

    }

}

// delete notes
extension ViewController/*: UITableViewDelegate, UITableViewDataSource*/ {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath] , with: .fade)
            
            tableView.endUpdates()
        }
    }
    
}

    
    
