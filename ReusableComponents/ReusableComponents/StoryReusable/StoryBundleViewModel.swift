//
//  StoryViewModel.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 10/12/24.
//
import SwiftUI

class StoryBundleViewModel: ObservableObject {
    /// Stories
    @Published var storyBundles: [StoryBundle] = StoryBundle.data
   // var bundles: StoryBundle
    // View Properties
    @Published var isShowingStoryBundle = false
    @Published var currentBundle: StoryBundle? = nil
    @Published var isAnimating: Bool = false
    
}
