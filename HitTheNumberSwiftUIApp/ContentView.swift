//
//  ContentView.swift
//  HitTheNumberSwiftUIApp
//
//  Created by Sergey on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = Float.random(in: 0...100)
    @State private var score = 0
    @State private var showAlert = false
    
    private var text: String {
        "Подвиньте слайдер как можно ближе к: \(targetValue)"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(text)
            HStack {
                Text("0")
                SliderView(currentValue: $currentValue, score: $score)
                    .onAppear {
                        score = computerScore()
                    }
                    .onChange(of: currentValue) { _ in
                        score = computerScore()
                    }
                Text("100")
            }
            Button("Проверь меня!") {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Ваш счёт"),
                      message: Text("\(computerScore())"))
            }
            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
                score = computerScore()
            }
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
