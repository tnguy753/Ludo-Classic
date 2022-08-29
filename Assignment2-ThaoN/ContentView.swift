/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Thi Huong Thao
  ID: s3891825
  Created  date: 15/08/2022
  Last modified: 29/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/
//
//  ContentView.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 15/08/2022.
//

import SwiftUI

struct ContentView: View {

    var gradient: Gradient {
             let stops: [Gradient.Stop] = [
                .init(color: Color("Color2"), location: 0.5),
                .init(color: Color("Color3"), location: 0.5)
             ]
             return Gradient(stops: stops)
         }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 150, idealWidth: 150, maxWidth: 500, minHeight: 150, idealHeight: 150, maxHeight: 500, alignment: .center)
                    HStack {
                        NavigationLink(destination: GameModeView()){
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 120, height: 50, alignment: .center)
                                .foregroundColor(Color("Color2"))
                            Text("PLAY")
                                .font(.custom("PressStart2P-Regular", size: 20))
                                .foregroundColor(Color("Color3"))}
                            
                        }
                        NavigationLink(destination: HelpView()){
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .frame(width: 120, height: 50, alignment: .center)
                                    .foregroundColor(Color("Color5"))
                                Text("HELP")
                                    .font(.custom("PressStart2P-Regular", size: 20))}
                                    .foregroundColor(Color("Color3"))
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .onAppear(perform: {playSound(sound: "gamemusic", type: "mp3")})
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)

    }
       
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
          
    }
}
