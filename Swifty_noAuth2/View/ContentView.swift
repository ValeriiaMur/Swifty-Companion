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
    @EnvironmentObject var user: User
    @State var name: String = ""
    @State private var showCancelButton: Bool = false
    @State private var showingAlert = false
//    @State private var showSecondView = false
    
    let CLIENT_ID = "df2ab74f597c91ec94d1302dc1981f0ea517a466c970d55f71816028e83a70fd"
    let redirect_uri = "myapp://oauth/callback"
    let CLIENT_SECRET = "c4f2f864e1de82b8e261b4473f3bc346dd0b6631419f723b8bc61c6df820d723"

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
                        let statusCode = response.response?.statusCode
                        //print(statusCode as Any)
                        if (response.result.value != nil && response.result.isSuccess && statusCode == 200) {
                            let swiftyJsonVar = JSON(response.result.value!)
                            self.parseUser(json : swiftyJsonVar)
                        } else if (statusCode == 404){
                            print("not found notFound")
                        }
                    }
    }
    func parseUser(json : JSON){
        self.user.name = json["first_name"].string!
        self.user.email = json["email"].string!
        self.user.intra = json["login"].string!
        self.user.lastname = json["last_name"].string!
        self.user.level = json["cursus_users"][0]["level"].int!
        
        if let jsonArray = json["projects_users"].array
        {
            for item in jsonArray
            {
                if let jsonDict = item.dictionary
                {
                    let projectName = jsonDict["project"]!["name"].string
                    self.user.projects[projectName!] = jsonDict["validated?"]!.bool
                 }
             }
        }
        
//        let jsonArray = json["projects_users"].array
//        user.projects[0] = jsonArray![0]["project"]["name"].string as Any
//        if let userName = jsonArray![0]["project"]["name"].string {
//            let pro = Projects.init(id: 1, name: userName, status: 1)
//            print(pro)
//       }
        
       // user.projects = json["projects_users"]
       
        
        //skills
        if (json["cursus_users"][0]["skills"][0]["level"].int != nil) {
            self.user.data["Company experience"] = json["cursus_users"][0]["skills"][0]["level"].int!
        }
        if (json["cursus_users"][0]["skills"][1]["level"].int != nil) {
            self.user.data["Group & interpersonal"] = json["cursus_users"][0]["skills"][1]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][2]["level"].int != nil) {
             self.user.data["Algorithms & AI"] = json["cursus_users"][0]["skills"][2]["level"].int!
        }
        if (json["cursus_users"][0]["skills"][3]["level"].int != nil) {
            self.user.data["Adaptation & creativity"] = json["cursus_users"][0]["skills"][3]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][4]["level"].int != nil) {
             self.user.data["Graphics"] = json["cursus_users"][0]["skills"][4]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][5]["level"].int != nil) {
            self.user.data["Rigor"] = json["cursus_users"][0]["skills"][5]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][6]["level"].int != nil) {
            self.user.data["Imperative programming"] = json["cursus_users"][0]["skills"][6]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][7]["level"].int != nil) {
            self.user.data["Unix"] = json["cursus_users"][0]["skills"][7]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][8]["level"].int != nil) {
            self.user.data["Object-oriented programming"] = json["cursus_users"][0]["skills"][8]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][9]["level"].int != nil) {
            self.user.data["Web"] = json["cursus_users"][0]["skills"][9]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][10]["level"].int != nil) {
            self.user.data["Network & system administration"] = json["cursus_users"][0]["skills"][10]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][11]["level"].int != nil) {
            self.user.data["DB & Data"] = json["cursus_users"][0]["skills"][11]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][12]["level"].int != nil) {
            self.user.data["Technology integration"] = json["cursus_users"][0]["skills"][12]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][13]["level"].int != nil) {
            self.user.data["Security"] = json["cursus_users"][0]["skills"][13]["level"].int!
        }
        if(json["cursus_users"][0]["skills"][14]["level"].int != nil) {
            self.user.data["Organization"] = json["cursus_users"][0]["skills"][14]["level"].int!
        }
        //request image and dowload. compress and round shape
        Alamofire.request(json["image_url"].string!).responseImage { response in
            if let image = response.result.value {
                image.af_inflate()
                let circularImage = image.af_imageRoundedIntoCircle()
                self.user.image = circularImage
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
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
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("Dec, 2019")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.black)
                    }.padding()
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
            }
            .simultaneousGesture(TapGesture().onEnded{
                    if (!self.name.isEmpty){
                       // self.showSecondView = true
                        self.getToken(string: self.name)
                    }
                    else {
                        self.showingAlert = true
                    }
                })
            .alert(isPresented: $showingAlert) {
            Alert(title: Text("Swifty Companion"), message: Text("Please enter a valid intra name. This user was not found"), dismissButton: .default(Text("Got it!")))
            }
            .background(Color.gray)
            .foregroundColor(Color.white)
            .background(Color.gray)
            .padding(10)
            .border(Color.gray, width: 5)
            }
            .padding()
            }
            Spacer()
        }.background(Image("Home"))
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
