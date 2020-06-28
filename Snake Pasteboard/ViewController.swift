//
//  ViewController.swift
//  Snake Pasteboard
//
//  Created by Yifan Ai on 26/4/20.
//  Copyright © 2020 Yifan Ai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let DATA_KEY = "data_key"
    
    @IBOutlet weak var textBox: UITextView!
    
    var copiedStrings: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedStrings = UserDefaults.standard.stringArray(forKey: DATA_KEY) {
            copiedStrings.append(contentsOf: loadedStrings)
        }
        showCopy()
    }
    
    func addCopy() {
        guard let text = UIPasteboard.general.string, !copiedStrings.contains(text) else {
            return
        }
        copiedStrings.append(text)
        showCopy()
        UserDefaults.standard.set(copiedStrings, forKey: DATA_KEY)
    }

    func showCopy() {
        textBox.text = ""
        for s in copiedStrings {
            textBox.text.append("\(s)\n\n\n")
        }
    }
    
    @IBAction func trashButton(_ sender: Any) {
        let alert = UIAlertController(title: "Clear Pasteboard?", message: "Are you sure you want to clear your pasteboard?", preferredStyle: UIAlertController.Style.actionSheet)

        alert.addAction(UIAlertAction(title: "Clear", style: UIAlertAction.Style.destructive, handler: clearCopy))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearCopy(alert: UIAlertAction!) {
        textBox.text = ""
        copiedStrings.removeAll()
        UserDefaults.standard.removeObject(forKey: DATA_KEY)
    }

    @IBAction func actionButton(_ sender: Any) {
        let controller = UIActivityViewController(activityItems: [textBox.text!], applicationActivities: nil)
        controller.excludedActivityTypes = []
        self.present(controller, animated: true, completion: nil)
    }
    
}
