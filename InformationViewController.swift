//
//  InformationViewController.swift
//  Restaurant
//
//  Created by 王皓天 on 2022/5/17.
//

import Foundation
import UIKit

class InformationViewController: UIViewController {
    public var orderModel = OrderModel()
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var numTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var speReqTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    @IBAction func Click(_ sender: Any) {
        performSegue(withIdentifier: "saveInfo", sender: nil)
        submitInfo()
    }
    
    func submitInfo(){
        var model = OrderModel()
        model.name = nameTextField.text!
        model.numberof_seat_time = datePicker.date
        model.numberof_seat = Int64(numTextField.text!)!
        model.phone = phoneTextField.text!
        model.remarks = speReqTextField.text!
        model.email = emailTextField.text!
        model.orderID = UUID().uuidString
        _ = DBManager.share.addOneOrder(orderModel: model)
    }
    
    //date picker
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        timeTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //transfer information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveInfo"{
            let VC = segue.destination as! RecordViewController
            VC.userID = idTextField.text!
            VC.userName = nameTextField.text!
            VC.numOfPeople = numTextField.text!
            VC.phoneNum = phoneTextField.text!
            VC.email = emailTextField.text!
            VC.bookingTime = timeTextField.text!
            VC.message = speReqTextField.text!
        }
    }
}
