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

//struct User : Hashable, Codable{
//
//    let name: String
//    let email : String
//    let intra : String
//}

class User: ObservableObject {
    @Published var name = ""
    @Published var lastname = ""
    @Published var email = ""
    @Published var intra = ""
    @Published var level = 0
    @Published var image = UIImage(named: "photo")
}


