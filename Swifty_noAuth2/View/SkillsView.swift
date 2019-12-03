//
//  SkillsView.swift
//  Swifty_noAuth2
//
//  Created by Valeriia Muradian on 12/2/19.
//  Copyright © 2019 Valeriia Muradian. All rights reserved.
//

import SwiftUI

struct CapsuleBar: View {
    var value: Int
    var maxValue: Int
    var width: CGFloat
    var valueName: String
    var capsuleColor: ColorRGB
    var body: some View {
        VStack {
            
            Text("\(value)")
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.gray)
                    .opacity(0.1)
                    .frame(width: width, height: 400)
                Capsule()
                    .fill(
                        Color(.sRGB, red: capsuleColor.red, green: capsuleColor.green, blue: capsuleColor.blue)
                    )
                    .frame(width: width, height: CGFloat(value) / CGFloat(maxValue) * 400)
                    .animation(.easeOut(duration: 0.5))
            }
            
            Text("\(valueName)")
        }
    }
}

struct ColorRGB {
    var red: Double
    var green: Double
    var blue: Double
}

struct SkillsView: View {
    @EnvironmentObject var user: User
    private var data: [String: [Int]] = [
         "Data1": [0],
         "Data2": [6, 7, 8, 9, 10],
         "Data3": [28, 25, 30, 29, 23],
    ]
    @State private var dataPicker: String = "Data1"
    private var dataBackgroundColor: [String: ColorRGB] = [
        "Data1": ColorRGB(red: 44 / 255, green: 54 / 255, blue: 79 / 255),
        "Data2": ColorRGB(red: 76 / 255, green: 61 / 255, blue: 89 / 255),
        "Data3": ColorRGB(red: 56 / 255, green: 24 / 255, blue: 47 / 255)
    ]
    private var dataBarColor: [String: ColorRGB] = [
        "Data1": ColorRGB(red: 222 / 255, green: 44 / 255, blue: 41 / 255),
        "Data2": ColorRGB(red: 42 / 255, green: 74 / 255, blue: 150 / 255),
        "Data3": ColorRGB(red: 47 / 255, green: 57 / 255, blue: 77 / 255)
    ]
    mutating func update(data : NSDictionary)
    {
        print(self.data)
        self.data["Data1"]![0] = self.user.data["Company experience"]!
        self.data["Data2"]![1] = self.user.data["Algorithms & AI"]!
    }
    var body: some View {
        ZStack {
            Color(.sRGB,
                       red: self.dataBackgroundColor[dataPicker]!.red,
                       green: self.dataBackgroundColor[dataPicker]!.green,
                       blue: self.dataBackgroundColor[dataPicker]!.blue
                 ).edgesIgnoringSafeArea(.all)
                 .animation(.default)
                 VStack {
                     Text("\(user.intra) Skills Graph")
                         .foregroundColor(.white)
                         .font(.largeTitle)
                         .fontWeight(.bold)
                         .padding()
                      Picker("", selection: $dataPicker) {
                          Text("Skills1").tag("Data1")
                          Text("Skills2").tag("Data2")
                          Text("Skills3").tag("Data3")
                      }.pickerStyle(SegmentedPickerStyle())
                      .padding()
                    CapsuleGraphView(data: data[dataPicker]!, maxValueInData: data[dataPicker]!.max()!, spacing: 24, capsuleColor: dataBarColor[dataPicker]!)
                 }
             }
         }
}

struct CapsuleGraphView: View {
    @EnvironmentObject var user: User
    var data: [Int]
    var maxValueInData: Int
    var spacing: CGFloat
    var capsuleColor: ColorRGB
    

//    self.user.data["Imperative programming"] = json["cursus_users"][0]["skills"][6]["level"].int!
//    self.user.data["Unix"] = json["cursus_users"][0]["skills"][7]["level"].int!
//    self.user.data["Object-oriented programming"] = json["cursus_users"][0]["skills"][8]["level"].int!
//    self.user.data["Web"] = json["cursus_users"][0]["skills"][9]["level"].int!
//    self.user.data["Network & system administration"] = json["cursus_users"][0]["skills"][10]["level"].int!
//    self.user.data["DB & Data"] = json["cursus_users"][0]["skills"][11]["level"].int!
//    self.user.data["Technology integration"] = json["cursus_users"][0]["skills"][12]["level"].int!
//    self.user.data["Security"] = json["cursus_users"][0]["skills"][13]["level"].int!
//    self.user.data["Organization"] = json["cursus_users"][0]["skills"][14]["level"].int!
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                CapsuleBar(value: self.data[0],
                    //self.user.data["Company experience"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8          * self.spacing) / CGFloat(self.data.count),
                           valueName: "Company",
                           capsuleColor: self.capsuleColor
                 )
                CapsuleBar(value: self.data[1],
                    //self.user.data["Algorithms & AI"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "AI",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.data[2],
                    //self.user.data["Adaptation & creativity"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Creativity",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.data[3],
                    //self.user.data["Graphics"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Graphics",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.data[4],
                    //self.user.data["Rigor"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Rigor",
                           capsuleColor: self.capsuleColor
                 )
            }
        }.frame(height: 500)
        
    }
}

struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView()
    }
}
