//
//  UserInfoView.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 11/30/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import SwiftUI

struct UserInfoView: View {
    var body: some View {
        VStack {
            Image("Background")
                .edgesIgnoringSafeArea(.top)
                .frame(width: 400.0, height: 200.0)
            Image("ProfilePhoto")
                .padding(.bottom, -20)
            VStack(alignment: .leading)
            {
                Text("Full Name")
                    .font(.title)
                HStack {
                    Text("Level 1")
                        .font(.subheadline)
                    Spacer()
                    Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
