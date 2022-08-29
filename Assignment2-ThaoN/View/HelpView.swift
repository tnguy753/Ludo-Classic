/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Thi Huong Thao
  ID: s3891825
  Created  date: 19/08/2022
  Last modified: 29/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/
//
//  HelpView.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 19/08/2022.
//

import SwiftUI

let screen = UIScreen.main //Declare

struct HelpView: View {
    
var body: some View {
    NavigationView {
        GeometryReader{ proxy in
            ZStack{
                // Ellipse Shape on top as background
                Ellipse().fill(Color("Color1"))
                    .rotationEffect(.degrees(90))
                    .offset(y: -screen.bounds.width*0.8)
                    .edgesIgnoringSafeArea(.top)
                
                // Back-Icon-Button navigates to homepage
                VStack {
                    HStack {
                        NavigationLink(destination: ContentView()){
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 50, idealWidth: 50, maxWidth: 70)
                        }.padding()
        
                        Spacer()
                    }
                    Spacer()
                } .padding()
                
                // CONTENTS
                VStack(alignment: .center, spacing: 24) {
                    // Title
                    Text("How-to-play")
                        .font(.custom("PressStart2P-Regular", size: 30))
                        .foregroundColor(.white)
                    
                    // Game Instruction Images horizontal style
                    VStack(alignment: .center, spacing: 30) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                //Loop through pictures from album array
                                ForEach(images, id:\.id){ image in
                                    GeometryReader{proxy in
                                        ImageCard(image: image)
                                        // Special Effect as scrolling
                                            .rotation3DEffect(.degrees(Double(proxy.frame(in: .global).minX - 20) / -20), axis: (x:0, y: 1, z:0))
                                    }
                                    .frame(width:screen.bounds.width/2, height: screen.bounds.height/2)
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical)
     
                    }
                    
                }
                .background(Color.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
                .edgesIgnoringSafeArea(.bottom)
                
            }
            
            .navigationBarHidden(true)
          
        }
      
    }
    .navigationBarHidden(true)
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarBackButtonHidden(true)
    
}
    struct HelpView_Previews: PreviewProvider {
        static var previews: some View {
            HelpView()
            
        }
        
    }
    
}
