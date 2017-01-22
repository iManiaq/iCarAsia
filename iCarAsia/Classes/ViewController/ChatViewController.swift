//
//  ChatViewController.swift
//  iCarAsia
//
//  Created by Sachin on 22/01/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    
    var dataSource = [String]()
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardWasShown(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func sendAction(sender: AnyObject) {
        if textArea.text.trimmedString.characters.count > 0 {
            dataSource.append( textArea.text.processedString)
            textArea.text = ""
            tabelView.reloadData()
        }
    }
    
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = 0
        })
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell", forIndexPath: indexPath) as! ChatTableViewCell
        cell.textInfoLabel.text = dataSource[indexPath.item]
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let text = dataSource[indexPath.item]
        return text.requiredHeight(UIFont.systemFontOfSize(16), width: self.view.bounds.width)
    }
}
