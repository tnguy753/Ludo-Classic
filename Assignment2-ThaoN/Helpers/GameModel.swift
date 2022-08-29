/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Thi Huong Thao
  ID: s3891825
  Created  date: 23/08/2022
  Last modified: 28/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/
//
//  GameModel.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 23/08/2022.
//

import Foundation
import SwiftUI

var gameModes:[Modes] =
[
    Modes(level: "Easy"),
    Modes(level: "Medium"),
    Modes(level: "Hard"),
]

struct Modes: Identifiable {
    var id = UUID()
    var level: String
}

struct UserScore: Identifiable {
    var id = UUID()
    var username: String
    var score: Double
}

struct Images: Identifiable {
    var id = UUID()
    var images: String
}

var images:[Images] =
[
Images(images: "help1"),
Images(images: "help2"),
Images(images: "help3"),
Images(images: "help4"),
Images(images: "help5")
]
