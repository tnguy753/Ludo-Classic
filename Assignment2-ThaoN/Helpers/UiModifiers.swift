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
//  UiModifiers.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 28/08/2022.
//

import SwiftUI

struct IconButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .scaledToFit()
          .frame(minWidth: 50, idealWidth: 50, maxWidth: 70)
  }
}

struct GameStatusModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .scaledToFit()
          .frame(minWidth: 120, idealWidth: 120, maxWidth: 220)
  }
}

struct TextButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .scaledToFit()
          .frame(minWidth: 150, idealWidth: 150, maxWidth: 300, minHeight: 30, idealHeight: 30, maxHeight: 50)
  }
}

struct PopUpShape: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 220, idealWidth: 220, maxWidth: 460, minHeight: 150, idealHeight: 150, maxHeight: 450)
            .shadow(radius: 10)

    }
}

