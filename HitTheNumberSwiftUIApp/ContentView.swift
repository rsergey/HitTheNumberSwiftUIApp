//
//  ContentView.swift
//  HitTheNumberSwiftUIApp
//
//  Created by Sergey on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue: Float = 50
    @State private var score: Int = 1
    @State private var showAlert = false
    
    var text: String {
        "Подвиньте слайдер как можно ближе к: \(targetValue)"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text)
            HStack {
                Text("0")
                SliderView(currentValue: $currentValue, score: $score)
                    .onChange(of: currentValue) { _ in
                        score = computerScore()
                    }
                Text("100")
            }
            Button(action: {showAlert.toggle()}) {
                Text("Проверь меня!")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your score"),
                      message: Text("\(computerScore())"))
            }
            Button(action: {targetValue = Int.random(in: 0...100)}) {
                Text("Начать заново")
            }
            //
            Text("currentValue: \(lround(Double(currentValue)))")
            Text("score: \(score)")
            //
        }
        .padding()
    }
    
    private func computerScore() -> Int {
        let difference = abs(targetValue - lround(Double(currentValue)))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
