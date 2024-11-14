//
//  SideMenuUIKitSwiftUi.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 14/11/24.
//

//
//struct MenuWrapperView<Content: View>: UIViewControllerRepresentable {
//    @Binding var isMenuOpen: Bool
//    let content: Content
//
//    init(isMenuOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
//        self._isMenuOpen = isMenuOpen
//        self.content = content()
//    }
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//
//        let host = UIHostingController(rootView: content)
//        host.view.translatesAutoresizingMaskIntoConstraints = false
//        viewController.view.addSubview(host.view)
//
//        NSLayoutConstraint.activate([
//            host.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
//            host.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
//            host.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
//            host.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
//        ])
//
//        let swipeGesture = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe(_:)))
//        swipeGesture.direction = .right
//        viewController.view.addGestureRecognizer(swipeGesture)
//
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        uiViewController.view.subviews.first?.isHidden = !isMenuOpen
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: MenuWrapperView
//
//        init(_ parent: MenuWrapperView) {
//            self.parent = parent
//        }
//
//        @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
//            withAnimation {
//                parent.isMenuOpen.toggle()
//            }
//        }
//    }
//}
//
//struct SideMenuView: View {
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(alignment: .leading) {
//                HStack {
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                    Text("Profile Name")
//                        .font(.title)
//                        .padding(.leading, 8)
//                }
//                .padding(.top, 50)
//
//                VStack(alignment: .leading, spacing: 20) {
//                    NavigationLink("Home", destination: Text("Home View"))
//                    NavigationLink("Settings", destination: Text("Settings View"))
//                    NavigationLink("About", destination: Text("About View"))
//                }
//                .padding(.top, 30)
//                .font(.headline)
//                .foregroundColor(.primary)
//
//                Spacer()
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color(.systemGray6))
//            .padding(.trailing, geometry.size.width / 3)
//        }
//    }
//}
//
//struct MainView: View {
//    @State private var isMenuOpen = false
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//            NavigationStack {
//                ScrollView {
//                    Text("Main Content")
//                        .font(.largeTitle)
//                        .padding()
//                }
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button {
//                            withAnimation {
//                                isMenuOpen.toggle()
//                            }
//                        } label: {
//                            Image(systemName: "line.horizontal.3")
//                                .imageScale(.large)
//                        }
//                    }
//                }
//            }
//            .disabled(isMenuOpen)
//            .overlay {
//                Color.black.opacity(isMenuOpen ? 0.3 : 0)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation {
//                            isMenuOpen = false
//                        }
//                    }
//                }
//            if isMenuOpen {
//                SideMenuView()
//                    .transition(.move(edge: .leading))
//                    .zIndex(1)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onEnded { value in
//                    // Detect swipe direction
//                    if value.translation.width > 50 {
//                        // Open menu on right swipe
//                        withAnimation {
//                            isMenuOpen = true
//                        }
//                    } else if value.translation.width < -50 {
//                        // Close menu on left swipe
//                        withAnimation {
//                            isMenuOpen = false
//                        }
//                    }
//                }
//        )
//        .animation(.easeInOut, value: isMenuOpen)
//    }
//}
//

//
//  TestView.swift
//  Barberist
//
//  Created by Shohruhmirzo Alijonov on 06/11/24.
//

// nect
//import SwiftUI
//import UIKit
//
//// MARK: - Menu Wrapper with Dragging Behavior in UIKit
//struct DraggableMenuWrapper<Content: View>: UIViewControllerRepresentable {
//    @Binding var isMenuOpen: Bool
//    let menuWidth: CGFloat = 250
//    let content: Content
//
//    init(isMenuOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
//        self._isMenuOpen = isMenuOpen
//        self.content = content()
//    }
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//
//        // Main Content
//        let host = UIHostingController(rootView: content)
//        host.view.translatesAutoresizingMaskIntoConstraints = false
//        viewController.view.addSubview(host.view)
//
//        NSLayoutConstraint.activate([
//            host.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
//            host.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
//            host.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
//            host.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
//        ])
//
//        // Menu View as a SwiftUI hosting controller
//        let menuHost = UIHostingController(rootView: SideMenuView())
//        menuHost.view.backgroundColor = UIColor.clear
//        menuHost.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: viewController.view.frame.height)
//
//        viewController.addChild(menuHost)
//        viewController.view.addSubview(menuHost.view)
//
//        menuHost.didMove(toParent: viewController)
//        context.coordinator.menuView = menuHost.view
//
//        // Pan gesture for dragging
//        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
//        viewController.view.addGestureRecognizer(panGesture)
//
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        // Update menu visibility based on isMenuOpen
//        let menuXPosition = isMenuOpen ? 0 : -menuWidth
//        UIView.animate(withDuration: 0.3) {
//            context.coordinator.menuView?.frame.origin.x = menuXPosition
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: DraggableMenuWrapper
//        var menuView: UIView?
//        var initialPosition: CGFloat = -250
//
//        init(_ parent: DraggableMenuWrapper) {
//            self.parent = parent
//        }
//
//        // Handle the pan gesture
//        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
//            guard let menuView = menuView else { return }
//            let translation = gesture.translation(in: menuView)
//            let velocity = gesture.velocity(in: menuView)
//
//            switch gesture.state {
//            case .changed:
//                // Allow dragging within range only
//                let newX = max(initialPosition, min(0, initialPosition + translation.x))
//                menuView.frame.origin.x = newX
//            case .ended:
//                // Decide whether to open or close based on velocity or final position
//                if velocity.x > 500 || menuView.frame.origin.x > -menuView.frame.width / 2 {
//                    openMenu()
//                } else {
//                    closeMenu()
//                }
//            default:
//                break
//            }
//        }
//
//        func openMenu() {
//            withAnimation {
//                parent.isMenuOpen = true
//                UIView.animate(withDuration: 0.3) {
//                    self.menuView?.frame.origin.x = 0
//                }
//            }
//        }
//
//        func closeMenu() {
//            withAnimation {
//                parent.isMenuOpen = false
//                UIView.animate(withDuration: 0.3) {
//                    self.menuView?.frame.origin.x = -self.parent.menuWidth
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Side Menu View
//struct SideMenuView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Image(systemName: "person.circle")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                Text("Profile Name")
//                    .font(.title)
//                    .padding(.leading, 8)
//            }
//            .padding(.top, 50)
//
//            VStack(alignment: .leading, spacing: 20) {
//                NavigationLink("Home", destination: Text("Home View"))
//                NavigationLink("Settings", destination: Text("Settings View"))
//                NavigationLink("About", destination: Text("About View"))
//            }
//            .padding(.top, 30)
//            .font(.headline)
//            .foregroundColor(.primary)
//
//            Spacer()
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//}
//
//// MARK: - Main View with Draggable Menu
//struct MainView: View {
//    @State private var isMenuOpen = false
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//            DraggableMenuWrapper(isMenuOpen: $isMenuOpen) {
//                NavigationStack {
//                    VStack {
//                        Text("Main Content")
//                            .font(.largeTitle)
//                            .padding()
//                    }
//                    .toolbar {
//                        ToolbarItem(placement: .topBarLeading) {
//                            Button(action: {
//                                withAnimation {
//                                    isMenuOpen.toggle()
//                                }
//                            }) {
//                                Image(systemName: "line.horizontal.3")
//                                    .imageScale(.large)
//                            }
//                        }
//                    }
//                }
//                .disabled(isMenuOpen) // Disable main content when menu is open
//            }
//            .overlay(
//                Color.black.opacity(isMenuOpen ? 0.3 : 0)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation {
//                            isMenuOpen = false
//                        }
//                    }
//            )
//        }
//        .animation(.easeInOut, value: isMenuOpen)
//    }
//}
//
//

import SwiftUI
import UIKit

// MARK: - Side Menu View
struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Profile Name")
                    .font(.title)
                    .padding(.leading, 8)
            }
            .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink("Home", destination: Text("Home View"))
                NavigationLink("Settings", destination: Text("Settings View"))
                NavigationLink("About", destination: Text("About View"))
            }
            .padding(.top, 30)
            .font(.headline)
            .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Menu Wrapper with Dragging Behavior in UIKit
struct DraggableMenuWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isMenuOpen: Bool
    let menuWidth: CGFloat = 250
    let content: Content
    
    init(isMenuOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isMenuOpen = isMenuOpen
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        // Main Content
        let host = UIHostingController(rootView: content)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(host.view)
        
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
        ])
        
        // Menu View as a SwiftUI hosting controller
        let menuHost = UIHostingController(rootView: SideMenuView().ignoresSafeArea())
        menuHost.view.backgroundColor = UIColor.clear
        menuHost.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: viewController.view.frame.height)
        
        viewController.addChild(menuHost)
        viewController.view.addSubview(menuHost.view)
        
        menuHost.didMove(toParent: viewController)
        context.coordinator.menuView = menuHost.view
        
        // Pan gesture for dragging
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        viewController.view.addGestureRecognizer(panGesture)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update menu visibility based on isMenuOpen
        let menuXPosition = isMenuOpen ? 0 : -menuWidth
        UIView.animate(withDuration: 0.3) {
            context.coordinator.menuView?.frame.origin.x = menuXPosition
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: DraggableMenuWrapper
        var menuView: UIView?
        var initialPosition: CGFloat = -250
        
        init(_ parent: DraggableMenuWrapper) {
            self.parent = parent
        }
        
        // Handle the pan gesture
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let menuView = menuView else { return }
            let translation = gesture.translation(in: menuView)
            let velocity = gesture.velocity(in: menuView)
            
            switch gesture.state {
            case .changed:
                // Allow dragging within range only
                let newX = max(initialPosition, min(0, initialPosition + translation.x))
                menuView.frame.origin.x = newX
            case .ended:
                // Decide whether to open or close based on velocity or final position
                if velocity.x > 500 || menuView.frame.origin.x > -menuView.frame.width / 2 {
                    openMenu()
                } else {
                    closeMenu()
                }
            default:
                break
            }
        }
        
        func openMenu() {
            withAnimation {
                parent.isMenuOpen = true
                UIView.animate(withDuration: 0.3) {
                    self.menuView?.frame.origin.x = 0
                }
            }
        }
        
        func closeMenu() {
            withAnimation {
                parent.isMenuOpen = false
                UIView.animate(withDuration: 0.3) {
                    self.menuView?.frame.origin.x = -self.parent.menuWidth
                }
            }
        }
    }
}

// MARK: - Main View with Draggable Menu and Scrollable Content
struct MainView: View {
    @State private var isMenuOpen = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            DraggableMenuWrapper(isMenuOpen: $isMenuOpen) {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(0..<20) { index in
                                Text("Content Item \(index + 1)")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.top)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation {
                                    isMenuOpen.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }
                        }
                    }
                }
                .disabled(isMenuOpen) // Disable main content when menu is open
            }
            .overlay(
                Color.black.opacity(isMenuOpen ? 0.3 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }
            )
        }
        .animation(.easeInOut, value: isMenuOpen)
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
