//
//  RecordViewController.swift
//  Restaurant
//
//  Created by 王皓天 on 2022/5/17.
//

import Foundation
import UIKit

class RecordViewController: UIViewController {
    
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bookingTimeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var userID = ""
    var userName = ""
    var numOfPeople = ""
    var phoneNum = ""
    var email = ""
    var bookingTime = ""
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //execute when prog starts
        userIDLabel.text = userID
        userNameLabel.text = userName
        numOfPeopleLabel.text = String(numOfPeople)
        phoneNumLabel.text = phoneNum
        emailLabel.text = email
        bookingTimeLabel.text = bookingTime
        messageLabel.text = message
    }
    
}
