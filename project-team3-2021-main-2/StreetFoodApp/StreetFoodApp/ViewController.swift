//
//  ViewController.swift
//  StreetFoodApp
//
//  Created by David Kao on 2021-02-26.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //----------- Food Truck Properties --------
    //init persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodTruck:[FoodTruck]?
    //--------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fakeDemo()
        fetchFoodtruck()
    }

    //opens pin view
    @IBAction func openPinView(_ sender: Any) {
        let newViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "PinnedViewController") as! PinnedViewController
        deleteData()
        DispatchQueue.main.async {
            self.fakeDemo()
            newViewController.items = self.fetchFoodtruck()
            print("got data")
            print(self.fetchFoodtruck())
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    /*
        creat fake data
     */
    func fakeDemo(){
        let temp_truck = FoodTruck(context: context)
        temp_truck.email = "aa2020@gmail.com"
        temp_truck.foodTruckID = "BCIT_IOS_Team3"
        // defualt value set as the vancouer for longitude and latitude
        temp_truck.latitude = "0"
        temp_truck.longitude = "0"
        temp_truck.name = "ABC"
        temp_truck.operating = true
        temp_truck.phoneNumber = "778-888-8888"
        temp_truck.truckDescription = "The first known Pizza restaurant in the United States was in New York’s Little Italy. Gennaro Lombardi in 1905 opened his restaurant, but used a coal oven instead of a traditional wood burning oven, since coal was cheaper than wood in New York."
        temp_truck.website = "www.google.ca"
        
        let user1 = User(context: context)
        user1.comment="this is good pizza"
        user1.favourite = true
        user1.userId = 1
        
        let user2 = User(context: context)
        user2.comment="Fucking sexy pizza"
        user2.favourite = true
        user2.userId = 2
        
        temp_truck.addToUser(user1)
        temp_truck.addToUser(user2)
        //Save context
        try! context.save()
        print(temp_truck)
      
    }
    
    func deleteData() {
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodTruck")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }

  


    //after fetching the api pass data into here
    //upload them into sqlite
    func fetchFoodtruck() -> [FoodTruck] {
        do{
            let request = FoodTruck.fetchRequest() as NSFetchRequest<FoodTruck>
            self.foodTruck  = try! context.fetch(request)
            return self.foodTruck!
          
        }
        catch {
            print("could not fetch data")
        }
    }


}

