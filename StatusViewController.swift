//
//  StatusViewController.swift
//  Restaurant
//
//  Created by 王皓天 on 2022/5/17.
//

import Foundation
import UIKit

class StatusViewController: UIViewController {
    public var orderModelList = [OrderModel]()
    private var selOrderModel = OrderModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //refresh data
        DBManager.share.queryOrder { object in
            self.orderModelList = object
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    // click delete show alert
    private func sureDelete(row:Int)  {
        showAlertVC(message: "Are you Sure Delete it?", isHadCancelAction: true) {
            // delete coredata
            _  = DBManager.share.deleteOrder(orderModel: self.orderModelList[row])
            // query  new order
            DBManager.share.queryOrder { object in
                self.orderModelList = object
                self.tableView.reloadData()
            }
        }
        
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
    
    //UIStoryboardSegue prepare execute will call  it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showViewOrderViewController",
           let vc = segue.destination as? ViewOrderViewController{
            vc.orderModel = self.selOrderModel
        }
    }
    
    
    
    
}

extension StatusViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        cell.orderModel = orderModelList[indexPath.row]
        
        cell.operationHandler = {
            [weak self] isDelete in
            guard let weakSelf = self else {
                return
            }
            // delete
            if isDelete  {
                weakSelf.sureDelete(row: indexPath.row)
            }else{
                // view
                weakSelf.selOrderModel = weakSelf.orderModelList[indexPath.row]
                weakSelf.performSegue(withIdentifier: "showViewOrderViewController", sender: nil)
            }
        }
        return cell
    }
    
    
}
    
