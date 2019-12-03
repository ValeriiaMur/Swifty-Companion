//
//  UserInfoView.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 11/30/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire
import AlamofireImage

struct UserInfoView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Image("Background")
                .edgesIgnoringSafeArea(.top)
                .frame(width: 400.0, height: 100.0)
            if user.image != nil{
                Image(uiImage: user.image!)
                .padding()
            }
            else {
                Text("")

            }
            VStack(alignment: .leading)
            {
                HStack{
                    Text(user.name)
                        .font(.title)
                    Text(user.lastname)
                        .font(.title)
                        
                }
                .padding()
                HStack {
                    Text(user.email)
                        .font(.subheadline)
                    Spacer()
                    Text(user.intra)
                    Spacer()
                    if (user.level == 0)
                    {
                        Text("")
                    } else {
                        Text("Level: \(user.level)")
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
