//
//  hapticView.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 18/11/24.
//
import SwiftUI

struct HapticView: View {
    @State private var toggleState: Bool = false

    var body: some View {
        VStack {
            Toggle("Toggle Me", isOn: $toggleState)
                .padding()
                .withHaptic(option: .selection, onChangeOf: toggleState)
            
            Button("Trigger Success Haptic") {
                Haptics.shared.vibrate(option: .light)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
        }
        .padding()
    }
}
