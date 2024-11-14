//
//  SelectingTimeView.swift
//  Barbershop
//
//  Created by Shohjahon Rakhmatov on 24/12/23.
//

import SwiftUI

struct TextFieldPlaceholderAutoComplete: View {
    
    @State private var text = ""
    @State private var placeholderText = ""
    @State private var placeholderIndex = 0
    @State private var isTyping = true
    @State private var phase = 1
    private let firstPlaceholderText = "AD1234567"
    private let secondPlaceholderText = "JSHSHIR"
    
    var body: some View {
        ScrollView {
            TextField("", text: $text)
                .overlay(
                    Text(text.isEmpty ? placeholderText : "")
                        .foregroundColor(.gray)
                        .opacity(0.6)
                        .allowsHitTesting(false)
                        .animation(.easeInOut(duration: 0.1), value: placeholderText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
            
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.04), radius: 10)
                .onAppear {
                    startTypingAnimation()
                }
                .onChange(of: text) { newValue in
                    if newValue.isEmpty {
                        resetAnimation()
                    }
                }
        }
        .background(.gray.opacity(0.4))
    }
    
    private func startTypingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            guard text.isEmpty else {
                timer.invalidate()
                return
            }
            let currentText = phase == 1 ? firstPlaceholderText : secondPlaceholderText
            if isTyping {
                if placeholderIndex < currentText.count {
                    placeholderText.append(currentText[currentText.index(currentText.startIndex, offsetBy: placeholderIndex)])
                    placeholderIndex += 1
                } else {
                    isTyping = false
                }
            } else {
                if !placeholderText.isEmpty {
                    placeholderText.removeLast()
                } else {
                    isTyping = true
                    placeholderIndex = 0
                    phase = phase == 1 ? 2 : 1
                }
            }
        }
    }
    
    private func resetAnimation() {
        placeholderText = ""
        placeholderIndex = 0
        isTyping = true
        phase = 1
        startTypingAnimation()
    }
}
