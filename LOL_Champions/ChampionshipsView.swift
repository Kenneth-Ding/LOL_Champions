//
//  ChampionshipsView.swift
//  LOL_Champions
//
//  Created by User12 on 2021/1/1.
//

import SwiftUI

struct ChampionshipsView: View {
    let Championship : Championship
    @Binding var name: String
    @Binding var type: Int
    @Binding var position: Int
    @Binding var difficultyLevel: Double
    
    @State private var opacity: Double = 0
    @State private var rotateDegree: Double = -180
    var body: some View {
        ScrollView{
            VStack {
                Image(String(type) + String(position) + String(Int(difficultyLevel)))
                    .resizable()
                    .scaledToFit()
                    .frame(height:400)
                    .opacity(opacity)
                    .animation(
                        Animation.easeOut(duration: 5)
                    )
                    .onAppear {
                        opacity += 1
                    }
                Text(Championship.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Section(header: CustomHeader(name: "故事")){
                    Text(Championship.story)
                        .padding()
                        .font(.system(size: 20))
                        .cornerRadius(30)
                        .padding(30)
                    }
                }
        }
    }
}

struct CustomHeader: View {
    let name: String
    var body: some View {
        ZStack {
            Color(red: 0/255, green: 0/255, blue: 0/255).edgesIgnoringSafeArea(.all)
            HStack {
                Text(name)
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .frame(width: 370)
            Spacer()
        }.frame(width:410, height: 33)
    }
}


