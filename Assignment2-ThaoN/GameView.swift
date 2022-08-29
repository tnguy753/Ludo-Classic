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
//  GameView.swift
//  Assignment2-ThaoN
//
//  Created by Nguyễn Thảo on 15/08/2022.


import SwiftUI

struct GameView: View {
    
    var gameMode: Modes // Game Difficulty Mode
    @State var users: [UserScore] = [] // Users dictionary
    @State var username: String = "" // User's username Input
    
    // DEFAULT VALUE
    @State var step = 0
    @State var moves = 0
    @State var number1 = 1
    @State var number2 = 3
    @State var timeStopwatch = 0.0
    
    // TIMER DECLARATION
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // DEFAULT LIGHT MODE
    @State var theColorScheme: ColorScheme = .light
    
    // DEFAULT OBJECT'S POSITION
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    //DEFAULT BOOL VALUE
    @State private var timerRunning = false
    @State private var startAnimation: Bool = false
    @State private var userPopUp: Bool = true
    @State private var menuPopupState: Bool = false
    @State private var startGame: Bool = false
    @State private var showGameOverModal = false
    @State private var showWinModal = false
    @State private var showScoreModal = false

    // SWITCH BETWEEN LIGHT & DARK MODE
    func toggleColorScheme() {
           theColorScheme = (theColorScheme == .light) ? .dark : .light
       }
    
    // STORE USER'S SCORE HISTORY
    func setScore(){
        let newScore = UserScore(username: username, score: timeStopwatch)
        users.append(newScore)
        
    }
    
    // SORT SCORE IN ASCENDING ORDER
    func showLeaderboard(){
        self.showScoreModal = true
        users.sort(by: {$0.score < $1.score})
    }
    
    // SET MOVES DEPENDING ON LEVEL
    func setLevel(){
        if(gameMode.level == "Easy") {
            moves = 80
        } else if(gameMode.level == "Medium") {
            moves = 50
        } else {
            moves = 30
        }
    }
    
    // ACTIONS AFTER ROLLING
    func roll() {
        moves -= 1
        timerRunning = true
        startGame = true
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        self.number1 = .random(in: 1...6)
        self.number2 = .random(in: 1...6)
        withAnimation(.interpolatingSpring(
                        mass: 1,
                        stiffness: 80,
                        damping: 4,
                        initialVelocity: 0)) {
                            self.startAnimation.toggle()
                        }
        
        if (moves == 0){
            lose()
        }
        if self.number1 == self.number2  {
            step = number1
            playSound(sound: "match", type: "wav")
           
        }

    }
    
    // ACTIONS AFTER RESTARTING
    func restart() {
        startGame = false
        timerRunning = false
        self.timer.upstream.connect().cancel()
        showWinModal = false
        showGameOverModal = false
        timeStopwatch = 0.0
        setLevel()
        currentPosition = .zero
        newPosition = .zero
        step = 0
        userPopUp = true
    }
    
    // ACTIONS AFTER WINNING
    func win() {
        if startGame {
            timerRunning = false
            self.timer.upstream.connect().cancel()
            showWinModal = true
            playSound(sound: "win", type: "mp3")
            setScore()
        }
            
    }
    // ACTIONS AFTER LOSING
    func lose() {
        if startGame {
            timerRunning = false
            self.timer.upstream.connect().cancel()
            showGameOverModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("Color"))
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 10) {
                    gameHeader
                    gameBoard
                    gameDice
                }
                // BLURRED BACKGROUND WHEN MODAL APPEARS
                .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
                .blur(radius:  showWinModal ? 5 : 0 , opaque: false)
                .blur(radius:  userPopUp ? 5 : 0 , opaque: false)
                .blur(radius:  menuPopupState ? 5 : 0 , opaque: false)
                
                // GAMEOVER MODAL
                if showGameOverModal{
                    gameOverModal
                }
                // GAMEWIN MODAL
                if showWinModal{
                    gameWinModal
                }
                // USERINPUT MODAL
                if userPopUp {
                    usernamePopUp
                }
                // MENU MODAL
                if menuPopupState{
                    menuPopUp
                }
                // SCORE MODAL
                if showScoreModal{
                    leaderboard
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
          
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .colorScheme(theColorScheme)
    }
       
}


extension GameView {
    
    //  HEADER VIEW
    private var gameHeader: some View {
        VStack {
            HStack {
                NavigationLink(destination: GameModeView()){
                    Image("back")
                        .resizable()
                        .modifier(IconButtonModifier())
                }
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Text("Steps")
                        .font(.custom("PressStart2P-Regular", size: 20))
                    Text("\(step)")
                        .font(.custom("PressStart2P-Regular", size: 30))
                }
                Spacer()
                Button {
                    self.menuPopupState = true
                    timerRunning = false
                } label : {
                Image("menu")
                    .resizable()
                    .modifier(IconButtonModifier())
                }
            } .padding()
            
            HStack(alignment: .top) {
                ZStack(alignment: .center) {
                    Image("heart")
                        .resizable()
                        .modifier(GameStatusModifier())
                    Text("\(String(format: "%.1f", self.timeStopwatch))s")
                        .font(.custom("PressStart2P-Regular", size: 17))
                        .foregroundColor(.black)
                        .onReceive(self.timer){time in
                            if timerRunning{
                                timeStopwatch += 0.1}
                            
                        }
                    
                }
                ZStack(alignment: .center) {
                    Image("energy")
                        .resizable()
                        .modifier(GameStatusModifier())
                    Text("\(moves)")
                        .font(.custom("PressStart2P-Regular", size: 18))
                        .foregroundColor(.black)
                    
                }
            }
            .padding()
            
        }
        
    }
    
    // BOARD VIEW
    private var gameBoard: some View {
        ZStack() {
            Image("board")
                .resizable()
                .scaledToFit()
            VStack {
                Spacer()
                Image("pawn")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.red)
                    .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                                // 3.
                                .gesture(DragGesture()
                                    .onChanged { value in
                                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                                }   // 4.
                                    .onEnded { value in
                                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                                        print(self.newPosition.width)
                                        self.newPosition = self.currentPosition
                                    }
                            )
                
            }
            
        }
        
    }
    
    // DICE VIEW
    private var gameDice: some View {
        HStack {
            Button {
                self.roll()
            } label: {
                VStack {
                    HStack {
                            Image("\(number1)")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .offset(x: startAnimation ? 20 : 0, y: startAnimation ? -50 : 0)
                                .scaleEffect(startAnimation ? 1.0 : 1.0)
                            Image("\(number2)")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .offset(x: startAnimation ? 20 : 0, y: startAnimation ? -50 : 0)
                                .scaleEffect(startAnimation ? 1.0 : 1.0)

                        }
                       
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .frame(width: 120, height: 50, alignment: .center)
                                    .foregroundColor(Color("Color1"))
                                Text("Roll")
                                    .font(.custom("PressStart2P-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                           
                        }
                    }

                }
            Button {
                self.win()
            } label: {
                Image("finish")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 100, idealWidth: 100, maxWidth: 120, minHeight: 150, idealHeight: 150, maxHeight: 250)
                
            }
        }
        
    }
    
    // USERNAME INPUT VIEW
    private var usernamePopUp: some View {
        ZStack {
            Image("background")
                .resizable()
                .padding()
                .shadow(radius: 30)
                .edgesIgnoringSafeArea(.all)
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            VStack {
                HStack {
                    NavigationLink(destination: GameModeView()){
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 50, idealWidth: 50, maxWidth: 70)
                    }.padding()
                    Spacer()
                }
                Spacer()
            } .padding()
            VStack(alignment: .center) {
                Text(self.gameMode.level)
                    .font(.custom("PressStart2P-Regular", size: 20))
                    .foregroundColor(Color("Color3"))
                    .padding()
                TextField("\(Image(systemName: "person.fill")) Username", text: $username)
                    .font(.system(size: 20, weight: .regular))
                    .font(.custom("PressStart2P-Regular", size: 12))
                    .padding()
                    .foregroundColor(Color("Color3"))
                    .frame(width: UIScreen.main.bounds.width/2, height: 50)
                    .background(Color("Color2").cornerRadius(10)
                                                    )
            Button {
                self.userPopUp = false
                self.setLevel()
            } label: {
                ZStack {
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: 250, minHeight: 50, idealHeight: 60, maxHeight: 150, alignment: .center)

                }
                
            }
            .onAppear(perform: {playSound(sound: "backgroundmusic", type: "mp3")})
            }
            
        }
        
    }
    
    // MENU POP UP VIEW
    private var menuPopUp: some View {
        ZStack {
            Image("popup")
                .resizable()
                .scaledToFit()
                .frame(minHeight: 200, idealHeight: 200, maxHeight: 700, alignment: .center)
            VStack {
                Button {
                    self.menuPopupState = false
                } label: {
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: 250, minHeight: 50, idealHeight: 60, maxHeight: 150, alignment: .center)
                }
                HStack {
                    Button(action: self.toggleColorScheme, label: {
                        Image("setting")
                            .resizable()
                            .modifier(IconButtonModifier())
                    })
                    Button {
                        self.showLeaderboard()
                    } label: {
                        Image("leaderboard")
                            .resizable()
                            .modifier(IconButtonModifier())
                    }
                    NavigationLink(destination: ContentView()){
                        Image("info")
                            .resizable()
                            .modifier(IconButtonModifier())
                        
                    }
                }
            }
        }
    }
    
    // TIMER VIEW
    private var timerSection: some View {
        ZStack {
            Image("energy")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 70, idealWidth: 70, maxWidth: 190)
            Text("\(String(format: "%.1f", self.timeStopwatch))s")
                .font(.custom("PressStart2P-Regular", size: 18))
                .foregroundColor(Color("Color3"))
                .onReceive(self.timer){time in
                    if self.timerRunning{
                        timeStopwatch += 0.1

                    }

            }
    
        }
        .padding()

    }
    
    // GAMEOVER VIEW
    private var gameOverModal: some View{
        ZStack {
            Capsule()
                .foregroundColor(.gray)
                .modifier(PopUpShape())
            VStack(spacing: 10) {
                Image("lose")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                Text("Out of moves")
                    .font(.custom("PressStart2P-Regular", size: 15))
                    .foregroundColor(.white)
                    .padding()
                Button {
                    self.restart()
                } label: {
                    ZStack {
                        Image("button")
                            .resizable()
                            .modifier(TextButtonModifier())
                        Text("Restart")
                            .font(.custom("PressStart2P-Regular", size: 15))
                            .foregroundColor(.white)
                    }
                    
                }
                NavigationLink(destination: GameModeView()) {
                    ZStack {
                        Image("button")
                            .resizable()
                            .modifier(TextButtonModifier())
                        Text("Home")
                            .font(.custom("PressStart2P-Regular", size: 15))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
        }
    }
    
    // LEADERBOARD VIEW
    private var leaderboard: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color("Color4"), Color("Color3")]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            VStack() {
                HStack {
                    Spacer()
                    Spacer()
                    Button(action: {
                        self.showScoreModal = false
                    }, label: {
                        ZStack {
                            Image("exit")
                        }
                        .padding()
                    }
                    )
                    
                }
                VStack(alignment:.center) {
                Image("trophy")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 220, idealWidth: 220, maxWidth: 350, minHeight: 150, idealHeight: 150, maxHeight: 350)
                Text("Leaderboard")
                        .font(.custom("PressStart2P-Regular", size: 30))
                        .foregroundColor(Color("Color3"))
                        .background(Rectangle().fill(Color("Color2")))
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(zip(1..., users)), id: \.1.id) { idx, newScore in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("Color3"))
                                    .shadow(radius: 20)
                                    HStack {
                                        Text("\(idx)")
                                            .font(.custom("PressStart2P-Regular", size: 15))
                                            .padding()
                                        Spacer()
                                        Text(newScore.username)
                                            .font(.custom("PressStart2P-Regular", size: 15))
                                            .padding()
                                        Spacer()
                                        Text("\(String(format: "%.1f", newScore.score))s")
                                            .font(.custom("PressStart2P-Regular", size: 15))
                                            .padding()
                                    }
                                }
                            .padding()
                            .frame(width: 340, height: 50, alignment: .center)
                            }
                    }
                }.padding()
                
            }
        }
    }
    }
    
    // GAMEWIN VIEW
    private var gameWinModal: some View{
        ZStack {
            Capsule()
                .foregroundColor(Color("Color3"))
                .modifier(PopUpShape())
            VStack(alignment: .center, spacing: 25) {
                Image("win")
                .frame(maxHeight: 150)
                .padding()
                HStack {
                    Text("Remaining Moves:")
                        .foregroundColor(.white)
                        .font(.custom("PressStart2P-Regular", size: 15))
                    Text("\(moves)")
                        .foregroundColor(.white)
                        .font(.custom("PressStart2P-Regular", size: 14))
                }
                HStack {
                    Text("Duration:")
                        .foregroundColor(.white)
                        .font(.custom("PressStart2P-Regular", size: 15))
                    Text("\(String(format: "%.1f", self.timeStopwatch))s")
                        .foregroundColor(.white)
                        .font(.custom("PressStart2P-Regular", size: 15))
                }
                Button {
                    self.restart()
                } label: {
                    ZStack {
                        Image("button")
                            .resizable()
                            .modifier(TextButtonModifier())
                        Text("Restart")
                            .font(.custom("PressStart2P-Regular", size: 14))
                            .foregroundColor(.white)
                    }
                }
                Button(action: {
                    self.showLeaderboard()
                }, label:{
                        ZStack {
                            Image("button")
                                .resizable()
                                .modifier(TextButtonModifier())
                            Text("Leaderboard")
                                .font(.custom("PressStart2P-Regular", size: 14))
                                .foregroundColor(.white)
                        }
                })
            }
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameMode: gameModes[1])
        
    }
}

