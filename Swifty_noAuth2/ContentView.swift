//
//  ContentView.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 11/30/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire
import AlamofireImage

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ContentView: View {
    //var displayUser: User
    //static let sharedInstance = ContentView()
    @EnvironmentObject var user: User
    @State var name: String = ""
    @State private var showCancelButton: Bool = false
    
    let CLIENT_ID = "df2ab74f597c91ec94d1302dc1981f0ea517a466c970d55f71816028e83a70fd"
    let redirect_uri = "myapp://oauth/callback"
    let CLIENT_SECRET = "c4f2f864e1de82b8e261b4473f3bc346dd0b6631419f723b8bc61c6df820d723"
    
    func handleAPI(string : String) {
        self.getToken(string: string)
    }
    func getToken(string: String) {
        let params : [String : String ] = ["grant_type" : "client_credentials" ]
            let credentialData = "\(CLIENT_ID):\(CLIENT_SECRET)".data(using: String.Encoding.utf8)!
            let base64Credentials = credentialData.base64EncodedString(options: [])
            let headers = ["Authorization": "Basic \(base64Credentials)"]

            Alamofire.request("https://api.intra.42.fr/oauth/token",
                              method: .post,
                              parameters: params,
                              encoding: URLEncoding.default,
                              headers: headers).authenticate(user: CLIENT_ID, password: CLIENT_SECRET)
                                .responseJSON
                                {
                                    response in
                                    if response.result.value != nil && response.result.isSuccess{
                                        //print(response.result.value as Any)
                                           let swiftyJsonVar = JSON(response.result.value!)
                                        self.parseJson(json : swiftyJsonVar, string: string)
                                    } else {
                                        print("Error")
                                    }
                                }
            }
    func parseJson(json : JSON, string : String) {
                let intraName = string.lowercased()
                let mytoken = json["access_token"].string;
                let headers = ["Authorization": "Bearer " + mytoken! as String]
                let tokenParams = ["": mytoken]
        
                Alamofire.request("https://api.intra.42.fr/v2/users/\(intraName)",
                    method: .get,
                    parameters: tokenParams as Parameters,
                    encoding: URLEncoding.default,
                    headers: headers).responseJSON
                    {
                        response in
                        if response.result.value != nil && response.result.isSuccess{
                            //print(response)
                            let swiftyJsonVar = JSON(response.result.value!)
                            self.parseUser(json : swiftyJsonVar)
                        }
                        else {
                            print("Can't find this intra name")
                        }
                    }
    }
    func parseUser(json : JSON){
        self.user.name = json["first_name"].string!
        self.user.email = json["email"].string!
        self.user.intra = json["login"].string!
        self.user.lastname = json["last_name"].string!
        self.user.level = json["cursus_users"][0]["level"].int!
        
        Alamofire.request(json["image_url"].string!).responseImage { response in
            if let image = response.result.value {
                //print("image downloaded: \(image)")
                image.af_inflate()
                let circularImage = image.af_imageRoundedIntoCircle()
                self.user.image = circularImage
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Image("Icon42")
                .padding(.top, -100.0)
                .frame(width: 350.0)
                VStack(alignment: .center)
                {
                    Text("Swifty Companion")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                HStack {
                    Text("Created by vmuradia")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.gray)
                    Spacer()
                    Text("Dec, 2019")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.gray)
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $name, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.black)
                    .border(Color.black)
                    .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                Button(action: {
                    self.name = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(name == "" ? 0 : 1)
                }
            }
            .padding()
            VStack {
                NavigationLink(destination: UserInfoView()) {
                    Text("Search")
                }.simultaneousGesture(TapGesture().onEnded{
                    if (!self.name.isEmpty){
                        self.handleAPI(string: self.name)
                    }
                })
                .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.white)
            }
            .padding()
            }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
