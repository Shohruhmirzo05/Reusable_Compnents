//
//  ExampleScrollUsage.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 18/11/24.
//

// not working properly

import SwiftUI

struct StickyHeaderScrollView: View {
    @State private var previousScrollOffset: CGFloat = 0
    @State private var headerHidden: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header
            VStack {
                Text("Sticky Header")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .opacity(headerHidden ? 0 : 1)
                    .animation(.easeInOut, value: headerHidden)
            }
            .zIndex(1) // Ensures the header stays on top
            
            // Scrollable Content
            ScrollViewWithOnScrollChanged(
                .vertical,                  // Axis
                showsIndicators: true       // Shows scroll indicators
            ) {
                VStack {
                    ForEach(0..<50) { index in
                        Text("Row \(index)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                }
            } onScrollChanged: { origin in
                let delta = origin.y - previousScrollOffset
                headerHidden = delta > 0 && origin.y > 0 // Hide header when scrolling down
                previousScrollOffset = origin.y
            }
        }
    }
}

#Preview {
    StickyHeaderScrollView()
}
