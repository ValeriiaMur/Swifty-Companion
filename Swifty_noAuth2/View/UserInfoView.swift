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

var active = true

struct UserInfoView: View {
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            Image("Background")
                .edgesIgnoringSafeArea(.top)
                .frame(width: 400.0, height: 100.0)
            if user.image != nil{
                Image(uiImage: user.image!)
                .offset(y: -130)
                .padding(.bottom, -130)
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
                    if (user.intra.isEmpty)
                    {
                        Text("Not found")
                    }
                }
                .padding()
            }
            Spacer()
            NavigationLink(destination: SkillsView()) {
                    Text("View Skills")
                }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .padding(10)
            .border(Color.gray, width: 5)
        .padding()
        NavigationLink(destination: ProjectsView()) {
                Text("View Projects")
        }
        .padding()
        .background(Color.gray)
        .foregroundColor(.white)
        .padding(10)
        .border(Color.gray, width: 5)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
