//
//  UISliderView.swift
//  HitTheNumberSwiftUIApp
//
//  Created by Sergey on 17.09.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    @Binding var currentValue: Float
    @Binding var score: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = UIColor(red: 1,
                                        green: 0,
                                        blue: 0,
                                        alpha: 0.5)
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.changeSliderValue),
                         for: .valueChanged)
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = currentValue
        uiView.thumbTintColor = UIColor(red: 1,
                                        green: 0,
                                        blue: 0,
                                        alpha: CGFloat(Float(score) / 100))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $currentValue)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Float
        
        init(sliderValue: Binding<Float>) {
            self._sliderValue = sliderValue
        }
        
        @objc func changeSliderValue(_ sender: UISlider) {
            sliderValue = sender.value
        }
    }
}

struct UISliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(currentValue: .constant(40), score: .constant(60))
    }
}
