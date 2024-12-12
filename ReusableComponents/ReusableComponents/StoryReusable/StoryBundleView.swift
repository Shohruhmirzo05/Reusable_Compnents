//
//  Tabbar.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 10/12/24.
//

import SwiftUI

struct StoryBundleView: View {
    @StateObject var viewModel: StoryBundleViewModel
    var namespace: Namespace.ID
    
//    init(namespace: Namespace.ID) {
//        self.namespace = namespace
//    }
//    
    var body: some View {
        TabView(selection: $viewModel.currentBundle) {
            ForEach(viewModel.storyBundles) { bundle in
//                StoryCardContainer(namespace: namespace, showHeader: bundle.id != viewModel.currentBundle?.id, bundle: bundle)
//                    .tag(bundle)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background {
           // Color.onSurface.ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
       /// supposed to make the 3d animation work properly with ontapgesture and auto move
        .animation(.easeInOut, value: viewModel.currentBundle)
        .disabled(viewModel.isAnimating)
        .matchedGeometryEffect(id: "card-\(viewModel.currentBundle!.id)", in: namespace)
        .environmentObject(viewModel)
    }
}
