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



struct ProjectRow: View {
    @EnvironmentObject var user: User

    var body: some View {
        HStack {
            Text("BO")
        }
    }
}

struct ProjectsView: View {
    @EnvironmentObject var user: User

    var body: some View {
        HStack {
            Text("BABA")
            VStack {
                ForEach(user.projects, id: \.self){ project in
                    Text("\($project)")
                }

                Text("Ready or not, here I come!")
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
