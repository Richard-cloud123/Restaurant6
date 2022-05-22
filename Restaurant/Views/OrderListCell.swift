//
//  OrderListCell.swift
//  Restaurant
//
//  Created by ChubbyKki on 2022/5/16.
//

import UIKit

class OrderListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberof_seat_timeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var remarksLabel: UILabel!
    //use closure transfer data
    var operationHandler:((_ isDelete:Bool)->())?
    var orderModel:OrderModel!{
        didSet{
            nameLabel.text = "Name:" + orderModel.name
            // date Formatter for dateString
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd HH:mm"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            self.numberof_seat_timeLabel.text = "Numberof seat time:" + dateFormatter.string(from: orderModel.numberof_seat_time)
            self.phoneLabel.text = "Phone:" + orderModel.phone
            self.remarksLabel.text = "Remarks:" + orderModel.remarks
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteAction(_ sender: Any) {
        
        operationHandler?(true)
    }
    @IBAction func viewAction(_ sender: Any) {
        operationHandler?(false)
    }
}
