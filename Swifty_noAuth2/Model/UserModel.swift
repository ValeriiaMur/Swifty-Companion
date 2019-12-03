//
//  UserModel.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 12/1/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire
import AlamofireImage

class User: ObservableObject {
    @Published var name = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var intra = ""
    @Published var level = 0
    @Published var data: [String: Int] = [
         "Company experience": 0,
         "Group & interpersonal": 0,
         "Algorithms & AI" : 0,
         "Adaptation & creativity" : 0,
         "Graphics" : 0,
         "Rigor" : 0,
         "Imperative programming" : 0,
         "Unix" : 0,
         "Object-oriented programming" : 0,
         "Web" : 0,
         "Network & system administration" : 0,
         "DB & Data" : 0,
         "Technology integration" : 0,
         "Security" : 0,
         "Organization" : 0
    ]
    @Published var image = UIImage(named: "photo")
}


