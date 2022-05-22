//
//  DBManager.swift
//  Restaurant
//
//  Created by ChubbyKki on 2022/5/16.
//

import UIKit
import CoreData
let entityName = "Order"
class DBManager{
    typealias completionHandler = ((_ object:[OrderModel]) -> Void)
    private let viewContext: NSManagedObjectContext
    static var share = DBManager()
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        viewContext = appDelegate.persistentContainer.viewContext
    }
    
    
    //1 add
    func addOneOrder(orderModel:OrderModel) -> Bool {
        let newSchedule = NSEntityDescription.insertNewObject(forEntityName: entityName, into: viewContext) as! Order
        newSchedule.setValues(orderModel: orderModel)
       
        do {
            try viewContext.save()
            print("addOneSchedule success")
            return true
        } catch  {
            print("cannot  addOneSchedule ")
        }
        return true
    }
    //2 query all data
     func queryOrder(completion:completionHandler)  {
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         //let predicate = NSPredicate(format: "account = %@", userModel.account)
         //fetchRequest.predicate = predicate
         do {
             let fetchResults = try self.viewContext.fetch(fetchRequest)  as? [Order]
             var orderModelList = [OrderModel]()
             if fetchResults != nil && fetchResults!.count > 0{
                 for i in 0..<fetchResults!.count {
                     let fetchResult = fetchResults![i]
                     let orderModel = fetchResult.toOrderModel()
                     orderModelList.append(orderModel)
                 }
             }
             completion(orderModelList)
             print("querySchedule success")
          
            
         } catch  {
             print("querySchedule error")
             completion([OrderModel]())
         }
     }
    
    //3 edit Order
     func editOrder(orderModel:OrderModel)  -> Bool {
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         let predicate = NSPredicate(format: "orderID = %@", orderModel.orderID)
         fetchRequest.predicate = predicate
         do {
             let fetchResults = try self.viewContext.fetch(fetchRequest)  as? [Order]
             
             if let fetchResults =  fetchResults,
                let order =  fetchResults.first{
                 order.setValues(orderModel: orderModel)
                 try viewContext.save()
                 print("edit success")
                 return true
             }else{
                 print("edit error")
             }
         } catch  {
             print("edit error")
         }
         return false
     }
    
    //3 delete Order
     func deleteOrder(orderModel:OrderModel)  -> Bool {
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         let predicate = NSPredicate(format: "orderID = %@", orderModel.orderID)
         fetchRequest.predicate = predicate
         do {
             let fetchResults = try self.viewContext.fetch(fetchRequest)  as? [Order]
             
             if let fetchResults =  fetchResults,
                let order =  fetchResults.first{
                 self.viewContext.delete(order)
                 try viewContext.save()
                 print("edit success")
                 return true
             }else{
                 print("delete error")
             }
         } catch  {
             print("delete error")
         }
         return false
     }
}



extension Order {
    // ScheduleModel => Schedule
    func setValues(orderModel: OrderModel) {
        self.numberof_seat_time = orderModel.numberof_seat_time
        self.phone = orderModel.phone
        self.remarks = orderModel.remarks
        self.numberof_seat = orderModel.numberof_seat
        self.email = orderModel.email
        self.orderID = orderModel.orderID
        self.name = orderModel.name
    }
    // Schedule => ScheduleModel
    func toOrderModel() -> OrderModel {
        let orderModel = OrderModel(numberof_seat_time: self.numberof_seat_time ?? Date(),numberof_seat: self.numberof_seat, phone: self.phone ?? "", remarks: self.remarks ?? "", email: self.email ?? "", orderID: self.orderID ?? UUID().uuidString,name: self.name ?? "")
        
        return orderModel
        
    }
}
