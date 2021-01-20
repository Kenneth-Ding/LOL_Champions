//
//  ContentView.swift
//  LOL_Champions
//
//  Created by User19 on 2020/11/30.
//

import SwiftUI

struct ContentView: View {
    init(){
            UITableView.appearance().backgroundColor = .clear
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.systemFont(ofSize: 18),
                ], for: .normal)
        }
    var position = [top, jg, mid, ad, sup]
    var background = ["劫", "瑟雷西", "薩科", "李星", "科加斯"]
    @State private var name = ""
    @State private var selectedBackground = 0
    @State private var recommendChampion = false
    @State private var showSecondPage = false
    @State private var showActionSheet = false
    @State private var positionPick = 2
    @State private var showAlert1 = false
    @State private var Alert = false
    @State private var typesPick = 2
    @State private var userColor = Color.black
    @State private var difficultyLevel = 3.0
    @State private var showSheet = false
    
    var body: some View {
            VStack {
                Form{
                    if (!recommendChampion) {
                        Name(name: self.$name)
                    }
                    Toggle("前進召喚峽谷  ！！", isOn : $recommendChampion)
                    if(recommendChampion) {
                        Text("\(name)歡迎來到召喚峽谷！\r\n      請選擇喜好的英雄的類型")
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("英雄位置").font(.title3)
                        PositionPicker(position: self.$positionPick)
                        Text("英雄類型").font(.title3)
                        TypesPicker(type: self.$typesPick)
                        DifficultyLevelStepper(score: self.$difficultyLevel)
                        DifficultyLevelSlider(score: self.$difficultyLevel)
                        DisclosureGroup("個人化設定") {
                            Text("背景設定 (長按我)")
                                    .contextMenu {
                                        Button(action: {
                                            selectedBackground = 0
                                        }) {
                                            Text("劫")
                                        }
                                        Button(action: {
                                            selectedBackground = 1
                                        }) {
                                            Text("瑟雷西")
                                        }
                                        Button(action: {
                                            selectedBackground = 2
                                        }) {
                                            Text("薩科")
                                        }
                                        Button(action: {
                                            selectedBackground = 3
                                        }) {
                                            Text("李星")
                                        }
                                        Button(action: {
                                            selectedBackground = 4
                                        }) {
                                            Text("科加斯")
                                        }
                                    }
                        ColorPicker("設定字體顏色", selection: $userColor)
                        }
                    }
                    
                }.offset(y: 220)
                 .frame(height: 800)
                .foregroundColor(userColor)
                Button(action: {
                    if (!recommendChampion) {
                        showActionSheet = true
                    }
                    else if (positionPick == 3 && typesPick == 3 || positionPick == 3 && typesPick == 4){
                        showAlert1 = true
                    }
                    else {
                        showSecondPage = true
                    }
                }) {
                    Text("開始選角")
                        .font(.title)
                        .foregroundColor(Color.red)
                        .frame(width: 150, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.black)
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.red, lineWidth: 8))
                }

                .actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("請不要跳步驟，謝謝"),message: Text("請問你要"),buttons: [
                    .default(Text("乖乖打開設定"))])
                }
                .alert(isPresented: $showAlert1) { () -> Alert in
                    SwiftUI.Alert(title: Text("請再選一次"), message: Text("下路沒有坦克或刺客角喔"), dismissButton: .cancel())
                }
                .sheet(isPresented: self.$showSecondPage) {
                    ChampionshipsView (
                        Championship: position[positionPick][Int(difficultyLevel)-1],
                        name: self.$name,
                        type: self.$typesPick,
                        position: self.$positionPick,
                        difficultyLevel: self.$difficultyLevel
                    )
                }
                
                .offset(y: -50)
            }.background(Image("\(selectedBackground)").resizable().scaledToFill().scaleEffect(1.1).offset(y:-43))
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Name: View {
    @Binding var name: String
    
    var body: some View {
        TextField("請輸入召喚師名稱", text: self.$name)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3))
    }
}

struct PositionPicker: View {
    @Binding var position: Int
    
    let positions = ["上路", "打野", "中路", "下路", "輔助"]
    
    var body: some View {
        Picker("位置",selection: self.$position){
            ForEach(0 ..< positions.count) { (index) in
                Text(self.positions[index])
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

struct TypesPicker: View {
    @Binding var type: Int
    
    let types=["射手",  "鬥士", "法師" , "刺客", "坦克"]
    
    var body: some View {
        Picker("英雄類型",selection: self.$type){
            ForEach(0 ..< types.count) { (index) in
                Text(self.types[index])
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

//struct adTypesPicker: View {
//    @Binding var type: Int
//
//    let types=["射手", "法師", "鬥士"]
//
//    var body: some View {
//        Picker("ad英雄類型",selection: self.$type){
//            ForEach(0 ..< types.count) { (index) in
//                Text(self.types[index])
//            }
//        }.pickerStyle(SegmentedPickerStyle())
//    }
//}
//
//struct supTypesPicker: View {
//    @Binding var type: Int
//
//    let types=["法師", "鬥士", "刺客", "坦克"]
//
//    var body: some View {
//        Picker("sup英雄類型",selection: self.$type){
//            ForEach(0 ..< types.count) { (index) in
//                Text(self.types[index])
//            }
//        }.pickerStyle(SegmentedPickerStyle())
//    }
//}

struct DifficultyLevelSlider: View {
    @Binding var score: Double
    
    var body: some View {
        Slider(value: $score, in: 0...5,step: 0.5, minimumValueLabel: Text("0顆星"), maximumValueLabel:Text("5顆星")){
        }.accentColor(.green)
    }
}

struct DifficultyLevelStepper: View {
    @Binding var score: Double
    
    var body: some View {
        Stepper("操作難度：" + String(format: "%.1f", score), value: $score, in: 0 ... 5)
    }
}
