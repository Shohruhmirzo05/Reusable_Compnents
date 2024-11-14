//
//  AnimatedSideBar.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 14/11/24.
//

import SwiftUI

struct AnimatedSideBar<Content: View, MenuView: View, Background: View>: View {
    
    // Customization options
    var rotatesWhenExpands: Bool = true
    var disablesInteraction: Bool = true
    var sideMenuWidth: CGFloat = 200
    var cornerRadius: CGFloat = 25
    
    @Binding var showMenu: Bool
    
    @ViewBuilder var content: (UIEdgeInsets) -> Content
    @ViewBuilder var menuView: (UIEdgeInsets) -> MenuView
    @ViewBuilder var background: Background
    
    // View Properties
    @GestureState private var isDragging: Bool = false
    @State private var offserX: CGFloat = 0
    @State private var lastOFfsetX: CGFloat = 0
    /// Used Dim Content View when Side bar is being dragged
    @State private var progress: CGFloat = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets ?? .zero
            
            HStack {
                GeometryReader { _ in
                    menuView(safeArea)
                }
                .frame(width: sideMenuWidth)
                // clipping menu interaction beyond its width
                .contentShape(.rect)

                GeometryReader { _ in
                    content(safeArea)
                }
                .frame(width: size.width)
                .overlay {
                    if disablesInteraction && progress > 0 {
                        Rectangle()
                            .fill(.black.opacity(progress * 0.2))
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                                    reset()
                                }
                            }
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: progress * cornerRadius)
                }
                /// rotates when expands
                .scaleEffect(rotatesWhenExpands ? 1 - (progress * 0.1) : 1, anchor: .trailing)
                .rotation3DEffect(.init(degrees: rotatesWhenExpands ? (progress * -15) : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
            }
            .frame(width: size.width + sideMenuWidth, height: size.height)
            .offset(x: -sideMenuWidth)
            .offset(x: offserX)
            .contentShape(.rect)
            .simultaneousGesture(dragGesture)
        }
        .background(background)
        .ignoresSafeArea()
        .onChange(of: showMenu) { oldValue, newValue in
            withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                if newValue {
                    showSideBar()
                } else {
                    reset()
                }
            }
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, out, _ in
                out = true
            }.onChanged { value in
                guard value.startLocation.x > 10 else { return }
                
                /// This will limit the translation value from 0 to the side bar width, Thus, it will avoid over dragging the menu view.
                let translationX = isDragging ? max(min(value.translation.width + lastOFfsetX, sideMenuWidth), 0) : 0
                offserX = translationX
                calculateProgress()
            }.onEnded { value in
                guard value.startLocation.x > 10 else { return }
                
                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                    let velocityX = value.velocity.width / 8
                    let total = offserX + velocityX
                    
                    if total > (sideMenuWidth * 0.5) {
                        showSideBar()
                    } else {
                        reset()
                    }
                }
            }
    }
    
    /// Show's side bar
    func showSideBar() {
        offserX = sideMenuWidth
        lastOFfsetX = offserX
        showMenu = true
        calculateProgress()
    }
    
    /// Reset to its initial status
    func reset() {
        offserX = 0
        lastOFfsetX = 0
        showMenu = false
        calculateProgress()
    }
    
    /// Converts Offset into series of progress ranging from 0 - 1
    func calculateProgress() {
        progress = max(min(offserX / sideMenuWidth, 1), 0)
    }
}

