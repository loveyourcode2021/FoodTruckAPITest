//
//  ViewController.swift
//  ApiParseTest
//
//  Created by David Kao on 2021-03-08.
//

import UIKit

class ViewController: UIViewController {
    var foodtrucks: [FoodTruck] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let networker = Networker.shared
        
        networker.getFoodTruck{ (foodtruck, error) -> (Void) in
            if let _ = error {
                print(error)
              print("error let")
              return
            }
            
            guard let foodtrucks = foodtruck else {
                print("Error guard")
                return
            }
            self.foodtrucks = foodtrucks
            
            // reload the collection view
            DispatchQueue.main.async {
                print(self.foodtrucks)
                //self.collectionView.reloadData()
            }
            
        }
    }


}

