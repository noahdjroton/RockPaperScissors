//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Djroton Noé SOSSOU on 28/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var possibleMoves = ["rock", "paper", "scissors"].shuffled()
    @State private var appRandomMoveChoice = Int.random(in: 0...2)
    @State private var doesPlayerWin = Bool.random()
    @State private var maxNumberOfMove = 10
    @State private var score = 0
    @State private var showingFinalScore = false
    @State private var showingAnswer = false
    @State private var answerTitle = ""
    @State private var currentNumberOfMove = 0
    
    func moveTapped(_ number: Int) {
        if (currentNumberOfMove < maxNumberOfMove) {currentNumberOfMove += 1}
        switch (possibleMoves[number], possibleMoves[appRandomMoveChoice]) {
        case ("rock", "scissors"), ("paper", "rock"), ("scissors", "paper"):
            answerTitle = "Correct"
            score += 1
        default:
            answerTitle = "Wrong"
            if (score > 0) {score -= 1}
        }
        if(currentNumberOfMove == maxNumberOfMove ) {
            showingFinalScore = true
        } else {
            showingAnswer = true
        }
    }
    
    func keepPlaying() {
        possibleMoves.shuffled()
        appRandomMoveChoice = Int.random(in: 0...2)
        doesPlayerWin.toggle()
    }
    
    func reset() {
        keepPlaying()
        score = 0
        showingFinalScore = false
        showingAnswer = false
        currentNumberOfMove = 0
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                Text("The app choose : ").font(.title).fontWeight(.medium)
                Image(possibleMoves[appRandomMoveChoice])
                    .resizable()
                    .frame(width: 150, height: 150)
               
                Section(){ Text("What should you choose to ").font(.title).fontWeight(.medium)
                    doesPlayerWin ?  Text("WIN").font(.title).fontWeight(.bold).foregroundStyle(.green) : Text("LOSE").font(.title).fontWeight(.bold).foregroundStyle(.red)}
                HStack(alignment: .center) {
                    ForEach(0..<possibleMoves.count,  id: \.self){number in
                        
                        Button{
                            moveTapped(number)
                        } label: {
                            Image(possibleMoves[number])
                                .resizable()
                                .frame(width:  80, height: 80)
                        }
                        
                        
                    }
                }
            }
            
            .padding()
        }
        
        .alert(answerTitle, isPresented: $showingAnswer) {
            Button("Continue", action: keepPlaying)
        }
        
        .alert("Final Score", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text("Your total score is \(score)").foregroundStyle(score > 5 ? .green : .red)
        }
    }
}

#Preview {
    ContentView()
}
