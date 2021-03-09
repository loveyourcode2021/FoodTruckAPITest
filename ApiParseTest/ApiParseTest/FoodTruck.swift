//
//  FoodTruck.swift
//
//  Created by David Kao on 2021-03-08.
//  Copyright © 2021 Sam Meech-Ward. All rights reserved.
//

import Foundation

struct LastLocation: Codable {
  let time: Int
  let display: String
  let latitude: Double
  let longitude: Double
}

struct FoodTruck: Codable {
  let name: String
  let last: LastLocation?
  let phone: String?
  let url: String?
  let description: String?
  let identifier: String
  let email: String?
}

import UIKit

