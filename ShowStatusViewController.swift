//
//  ShowStatusViewController.swift
//  Restaurant
//
//  Created by 王皓天 on 2022/5/18.
//

import Foundation
import UIKit

class ShowStatusViewController: UIViewController{
    
    
    public var orderModel = OrderModel()
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberof_seat_timeLabel: UILabel!
    @IBOutlet weak var numberof_seatTFLabel: UILabel!
    @IBOutlet weak var remarksLabel: UILabel!
    //EditOrderViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setdata()
        
    }
    
    func setdata()  {
        self.nameLabel.text = self.orderModel.name
        self.phoneLabel.text = self.orderModel.phone
        self.emailLabel.text = self.orderModel.email
        self.numberof_seat_timeLabel.text = getDateStringWithDate(date: self.orderModel.numberof_seat_time)
        self.numberof_seatTFLabel.text = String(self.orderModel.numberof_seat)
        self.remarksLabel.text = self.orderModel.remarks
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditOrderViewController",
           let vc = segue.destination as? EditOrderViewController{
            vc.orderModel = self.orderModel
            // click save call closure
            vc.refreshHandler = {
                [weak self]orderModelTemp in
                self?.orderModel = orderModelTemp
                self?.setdata()
            }
        }
    }
    // date -> dataString
    func getDateStringWithDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
    
    
}
