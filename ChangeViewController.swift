//
//  ChangeViewController.swift
//  Restaurant
//
//  Created by 王皓天 on 2022/5/18.
//

import Foundation
import UIKit

class ChangeViewController: UIViewController{
    
    
    public var orderModel = OrderModel()
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var numberof_seat_timeTF: UITextField!
    @IBOutlet weak var numberof_seatTF: UITextField!
    @IBOutlet weak var remarksTextV: UITextView!
    
    var refreshHandler:((_ orderModel:OrderModel)->())?
    lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle  = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        
        //datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        datePicker.timeZone = TimeZone.current
        datePicker.calendar = Calendar.current
        datePicker.addTarget(self, action: #selector(datePickerValueChange(datePicker:)), for: UIControl.Event.valueChanged)
        return datePicker
    }()
    
    var selNumberof_seat_time = Date()
    //EditOrderViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // datePicker KeyBoard
        numberof_seat_timeTF.inputView = datePicker
        // KeyBoard top toolBar
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 40))
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let sureItem = UIBarButtonItem.init(title: "ok", style: .plain, target: self, action: #selector(hideKeyBoard))
        toolBar.setItems([spaceItem,sureItem], animated: true)
        numberof_seat_timeTF.inputAccessoryView = toolBar
        selNumberof_seat_time = orderModel.numberof_seat_time
        
        nameTF.text = orderModel.name
        phoneTF.text = orderModel.phone
        emailTF.text = orderModel.email
        remarksTextV.text = orderModel.remarks
        numberof_seat_timeTF.text = getDateStringWithDate(date: orderModel.numberof_seat_time)
        numberof_seatTF.text = String(orderModel.numberof_seat)
        
        remarksTextV.layer.cornerRadius = 6
        remarksTextV.layer.masksToBounds = true
        
        nameTF.becomeFirstResponder()
        
    }
    
    @objc func datePickerValueChange(datePicker:UIDatePicker)  {
        selNumberof_seat_time = datePicker.date
        numberof_seat_timeTF.text = getDateStringWithDate(date: selNumberof_seat_time)
    }
    
    func getDateStringWithDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
   
    @IBAction @objc func clickSaveData()  {
        // save
        //1Name
        guard let name = nameTF.text,
        name.count > 0 else {
            showAlertVC(message: "Name is empty", handler: nil)
            return
        }
        //2phone
        guard let phone = phoneTF.text,
              phone.count > 0 else {
                  showAlertVC(message: "Phone is empty", handler: nil)
            return
        }
        //3email
        guard let email = emailTF.text,
              email.count > 0 else {
                  showAlertVC(message: "Email is empty", handler: nil)
            return
        }
        //4numberof_seat_time
        guard let numberof_seat_time = numberof_seat_timeTF.text,
              numberof_seat_time.count > 0 else {
                  showAlertVC(message: "Numberof seat time is empty", handler: nil)
            return
        }
        //5numberof_seat
        guard let numberof_seat = numberof_seatTF.text,
              let numberof_seatInt = Int64(numberof_seat),
              numberof_seatInt >= 0 else {
                  showAlertVC(message: "numberof_seat seat time is error", handler: nil)
                  return
              }
        var editOrderModel = OrderModel()
        editOrderModel.orderID = orderModel.orderID
        editOrderModel.name = name
        editOrderModel.phone = phone
        editOrderModel.email = email
        //remarks is empty allow
        editOrderModel.remarks = self.remarksTextV.text!
        editOrderModel.numberof_seat_time = selNumberof_seat_time
        editOrderModel.numberof_seat = numberof_seatInt
        
        self.orderModel = editOrderModel
        // edit coradata success
        if DBManager.share.editOrder(orderModel: editOrderModel) == true{
            //ViewOrderViewController page updata data
            refreshHandler?(editOrderModel)
            // show Success Alert
            showAlertVC(message: "Save Success") {
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            showAlertVC(message: "Save error", handler: nil)
        }
        
    }
    
    
    @objc func hideKeyBoard(){
        //use to make the view or any subview that is the first responder resign (optionally force)
        self.view.endEditing(true)
    }
    
    
    //show Alert viewController
    func showAlertVC(message:String,isHadCancelAction:Bool = false, handler: (()->())?)  {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        if isHadCancelAction {
            let  cancelActin = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelActin)
        }
        let sureAction =  UIAlertAction(title: "Sure", style: .default) {
            _ in
            handler?()
        }
        alertVC.addAction(sureAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}
