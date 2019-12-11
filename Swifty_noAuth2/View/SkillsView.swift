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
         "Data1": [30, 30, 30, 30, 30],
         "Data2": [30, 30, 30, 30, 30],
         "Data3": [30, 30, 30, 30, 30],
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
                    if (dataPicker == "Data1")
                    {
                      CapsuleGraphView(data: data[dataPicker]!, maxValueInData: data[dataPicker]!.max()!, spacing: 24, capsuleColor: dataBarColor[dataPicker]!)
                    }
                    else if (dataPicker == "Data2")
                    {
                        CapsuleGraphView2(data: data[dataPicker]!, maxValueInData: data[dataPicker]!.max()!, spacing: 24, capsuleColor: dataBarColor[dataPicker]!)
                    }
                    else if (dataPicker == "Data3")
                    {
                        CapsuleGraphView3(data: data[dataPicker]!, maxValueInData: data[dataPicker]!.max()!, spacing: 24, capsuleColor: dataBarColor[dataPicker]!)
                    }
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

    var body: some View {
        GeometryReader { geometry in
            HStack {
                CapsuleBar(value: self.user.data["Company experience"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8          * self.spacing) / CGFloat(self.data.count),
                           valueName: "Company",
                           capsuleColor: self.capsuleColor
                 )
                CapsuleBar(value: self.user.data["Algorithms & AI"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Algorithms",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Adaptation & creativity"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Creativity",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Graphics"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Graphics",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Rigor"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Rigor",
                           capsuleColor: self.capsuleColor
                 )
            }
        }.frame(height: 500)
    }
}

struct CapsuleGraphView2: View {
    @EnvironmentObject var user: User
    var data: [Int]
    var maxValueInData: Int
    var spacing: CGFloat
    var capsuleColor: ColorRGB

    var body: some View {
        GeometryReader { geometry in
            HStack {
                CapsuleBar(value: self.user.data["Imperative programming"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8          * self.spacing) / CGFloat(self.data.count),
                           valueName: "Imperative",
                           capsuleColor: self.capsuleColor
                 )
                CapsuleBar(value: self.user.data["Unix"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Unix",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Object-oriented programming"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Object-oriented",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Web"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Web",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Network & system administration"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Network",
                           capsuleColor: self.capsuleColor
                 )
            }
        }.frame(height: 500)
    }
}

struct CapsuleGraphView3: View {
    @EnvironmentObject var user: User
    var data: [Int]
    var maxValueInData: Int
    var spacing: CGFloat
    var capsuleColor: ColorRGB
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                CapsuleBar(value: self.user.data["DB & Data"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8          * self.spacing) / CGFloat(self.data.count),
                           valueName: "DB&Data",
                           capsuleColor: self.capsuleColor
                 )
                CapsuleBar(value: self.user.data["Technology integration"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Integration",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Security"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Security",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Organization"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Organization",
                           capsuleColor: self.capsuleColor
                 )
                 CapsuleBar(value: self.user.data["Group & interpersonal"]!,
                           maxValue: self.maxValueInData,
                           width: (CGFloat(geometry.size.width) - 8 * self.spacing) / CGFloat(self.data.count),
                           valueName: "Group",
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
