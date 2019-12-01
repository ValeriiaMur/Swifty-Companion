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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct Search: View {
    @State var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                self.searchText = ""
                                self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton) .animation(.default)
                    .navigationBarTitle(Text("Search 42 logins")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray))
            }
        }
    }
}


struct ContentView: View {
    var search = Search()
    @State var name: String = ""
    let CLIENT_ID = "df2ab74f597c91ec94d1302dc1981f0ea517a466c970d55f71816028e83a70fd"
    let redirect_uri = "myapp://oauth/callback"
    let CLIENT_SECRET = "c4f2f864e1de82b8e261b4473f3bc346dd0b6631419f723b8bc61c6df820d723"
    
    func handleAPI(string : String)
    {
        print(string)
        self.getToken(string: string)
    }
    func getToken(string: String)
    {
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
                                           self.parseJson(json : swiftyJsonVar)
                                       }
                                   }
            }
            func parseJson(json : JSON) {
                //let find = search.searchText
                let mytoken = json["access_token"].string;
                let headers = ["Authorization": "Bearer " + mytoken! as String]
                //print(headers)
                               let tokenParams = ["": mytoken]
                               Alamofire.request("https://api.intra.42.fr/v2/users/",
                                       method: .get,
                                       parameters: tokenParams as Parameters,
                                       encoding: URLEncoding.default,
                                       headers: headers).responseJSON
                                       {
                                           response in
                                           if response.result.value != nil && response.result.isSuccess{
                                                    print(response)
                                           }
                                       }
            }
    var body: some View {
        
        VStack {
            Image("Background")
                .frame(width: 400.0)
                .edgesIgnoringSafeArea(.top)
                .frame(width: 400.0, height: 180.0)
            Image("Icon42")
                .padding(.top, -100.0)
                .frame(width: 150.0)
                
                
            VStack(alignment: .center)
            {
                Text("Swifty Companion")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                HStack {
                    Text("Created by vmuradia")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("Dec, 2019")
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            search
            Button(
                action: {self.handleAPI(string: self.search.searchText)},
                label: {
                    Text("Search")
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 40.0)
            } )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
