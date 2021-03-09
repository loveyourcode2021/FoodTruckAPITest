//
//  ViewController.swift
//  ApiParseTest
//
//  Created by David Kao on 2021-03-08.
//

import UIKit

class ViewController: UIViewController {
    var vendors: [String: FoodTruck] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let networker = Networker.shared
        
        networker.getFoodTruck{ (vendors, error) -> (Void) in
            if let _ = error {
              print("error")
              return
            }
            
            guard let vendors = vendors else {
                print("error foodtrucks are not foodtruck")
                return
            }
            self.vendors = vendors
            
            // reload the collection view
            DispatchQueue.main.async {
                for (_, foodtruck) in vendors {
                    //print("\(foodtruckname) -> \(foodtruck)")
                    print(foodtruck.name)
                    
                    let long = foodtruck.last?.longitude ?? 0
                    let lat = foodtruck.last?.latitude ?? 0
                    
                    if let phone = foodtruck.phone {
                        print(phone)
                    }


                    if let description = foodtruck.description {
                        print(description)
                    }

                    if let url = foodtruck.url {
                        print(url)
                    }

                    if let email = foodtruck.email {
                        print(email)
                    }

                   // let identifier = foodtruck.identifier

                    print("\("long "), \(long)")
                    print("\("lat "), \(lat)")
                    print("\n\n\n")
                }
                //self.collectionView.reloadData()
            }
            
        }
    }


}

