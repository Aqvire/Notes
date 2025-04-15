//
//  NoteViewController.swift
//  Notes
//


import UIKit

class NoteViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!

    
    public var noteTitle: String = ""
    public var note: String = ""
    
    public var delete = false

    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(didTapDelete))
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note
    }

    @objc func didTapDelete() {
        delete = true
        navigationController?.popViewController(animated: true)
        }

    
}
