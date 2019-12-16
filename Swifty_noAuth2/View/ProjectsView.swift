//
//  ProjectsView.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 12/5/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire
import AlamofireImage

struct Projects {
    var name : String
    var status : Int
}


struct ProjectRow: View {
    @EnvironmentObject var user: User
//    @State var all_proj = user.projects

    var body: some View {
        HStack {
            Text("Hello world!")
        }
    }
}

//struct ProjectsView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        HStack {
////            Text("BABA")
////            VStack {
//////                ForEach(user.projects, id: \.self){ project in
//////                    Text("\($project)")
//////                }
////            }
//        }
//    }
//}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
