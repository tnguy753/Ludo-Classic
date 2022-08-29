/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Thi Huong Thao
  ID: s3891825
  Created  date: 28/08/2022
  Last modified: 29/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/
//
//  ImageCard.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 28/08/2022.
//

import SwiftUI

// Customize Image Card to display
struct ImageCard: View {
    var image: Images
    let screen = UIScreen.main
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(image.images)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: screen.bounds.width/2, height: screen.bounds.height/2)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct ImageCard_Previews: PreviewProvider {
    static var previews: some View {
        ImageCard(image: images[0])
    }
}
