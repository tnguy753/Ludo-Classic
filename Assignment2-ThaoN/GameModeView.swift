/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Thi Huong Thao
  ID: s3891825
  Created  date: 23/08/2022
  Last modified: 29/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/
//
//  GameModeView.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 23/08/2022.
//

import SwiftUI

struct GameModeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Color5").edgesIgnoringSafeArea(.all)
                VStack() {
                    // TITLE
                    Text("Mode Select".uppercased())
                        .font(.custom("PressStart2P-Regular", size: 25))
                        .foregroundColor(Color("Color4"))
                        .padding()
                    Spacer()
                    // GAME MODE LIST
                    // Easy mode
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(Color("Color4"))
                        NavigationLink(destination: GameView(gameMode: gameModes[0])){ Text("Easy")
                            .font(.custom("PressStart2P-Regular", size: 20))
                            .foregroundColor(.white)
                        }
                        
                    }
                    // Medium mode
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(Color("Color4"))
                        NavigationLink(destination: GameView(gameMode: gameModes[1])){ Text("Medium")
                            .font(.custom("PressStart2P-Regular", size: 20))
                            .foregroundColor(.white)
                        }
                        
                    }
                    // Hard mode
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(Color("Color4"))
                        NavigationLink(destination: GameView(gameMode: gameModes[2])){ Text("Hard")
                            .font(.custom("PressStart2P-Regular", size: 20))
                            .foregroundColor(.white)
                        }
                        
                    }
                    Spacer()
                    
                    // IMAGE FOOTER
                    Image("dices")
                        .resizable()
                        .scaledToFit()

                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }


struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView()
    }
}
