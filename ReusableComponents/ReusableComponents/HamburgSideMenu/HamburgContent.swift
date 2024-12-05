//
//  HamburgContent.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 14/11/24.
//

import SwiftUI


struct HamburgContent: View {
    
    // View Properties
    @State private var showMenu: Bool = false
    
    var body: some View {
        AnimatedSideBar(
            rotatesWhenExpands: true, // supposed to be true
            disablesInteraction: true, // supposed to be true
            sideMenuWidth: 200 ,
            cornerRadius: 25,
            showMenu: $showMenu
        ) { safeArea in
            NavigationStack {
                List {
                    NavigationLink("Detail View") {
                        Text("Hello I am")
                            .navigationTitle("Detail")
                    }
                }
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showMenu.toggle()
                        } label: {
                            Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                .foregroundStyle(Color.primary)
                                .contentTransition(.symbolEffect)
                        }
                    }
                }
            }
            .environment(\.colorScheme, .light)
        } menuView: { safeArea in
            SideMenuView(safeArea)
        } background: {
            Rectangle()
                .fill(.sideMenu)
        }
    }
    
    @ViewBuilder func SideMenuView(_ safeArea: UIEdgeInsets) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Side Menu")
                .font(.largeTitle.bold())
                .padding(.bottom, 10)
            
            SideBarButton(.home)
            SideBarButton(.favourites)
            SideBarButton(.bookings)
            SideBarButton(.search)
            
            Spacer(minLength: 0)
            
            SideBarButton(.settings)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environment(\.colorScheme, .dark)
    }
    
    @ViewBuilder func SideBarButton(_ tab: TabItem, onTap: @escaping () -> () = { }) -> some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: tab.symbol)
                    .font(.title3)
                Text(tab.rawValue)
                    .font(.callout)
                Spacer(minLength: 0)
            }
            .padding(.vertical, 10)
            .contentShape(.rect)
            .foregroundStyle(.primary)
        }
    }
    
    enum TabItem: String, CaseIterable {
        case home = "Home"
        case search = "Search"
        case bookings = "Bookings"
        case favourites = "Favourites"
        case settings = "Settings"
        
        var symbol: String {
            switch self {
            case .home: return "house"
            case .search: return "magnifyingglass"
            case .bookings: return "calendar"
            case .favourites: return "heart"
            case .settings: return "gearshape"
            }
        }
    }
}

#Preview {
    HamburgContent()
}
