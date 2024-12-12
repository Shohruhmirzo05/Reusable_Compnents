//
//  StoryCard1.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 10/12/24.
//


import SwiftUI

struct StoryCard1View: View {
    var story: StoryBundle

    var body: some View {
        VStack(alignment: .leading) {
//            StoryHeaderView(story: story)
//                .padding(.horizontal, 24)
//                .padding(.vertical, 42)
//            Spacer()
            StoryBody()
            
        }
        .background {
            story.backgroundImage
                .resizable()
                .overlay {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [story.gradientColors[0], Color.clear]), startPoint: .top, endPoint: .bottom)
                        if story.gradientColors.count >= 2  {
                            LinearGradient(gradient: Gradient(colors: [Color.clear, story.gradientColors[1]]), startPoint: .top, endPoint: .bottom)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    @ViewBuilder func StoryBody() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Spacer()
            Text(story.summary.title)
                .font(.system(size: 18))
                .foregroundStyle(.white)

            HStack(spacing: 4) {
                Image("lightning")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 20, maxHeight: 20)
                    .foregroundStyle(.white)
                Text(story.summary.thesis)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .kerning(0.28)
            }
            .padding(8)
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            HStack(spacing: 28) {
                Image("facesStory1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    HStack {
                        Image("sentiment")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 40, maxHeight: 40)
//                        Text(story.summary.sentiment == .positive ? "Positive Sentiment" : story.summary.sentiment == .neutral ? "Neutral Sentiment" : "Negative Sentiment")
//                            .lineLimit(1)
                    }
                    HStack {
                        Image("strategicDiscussion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 40, maxHeight: 40)
//                        Text(story.summary.priority == .high ? "Strategic Discussion" : story.summary.priority == .medium ? "Balanced Discussion" : "Tactical Discussion")
                    }
                }
                .font(.system(size: 12))
                .kerning(0.48)
                .foregroundStyle(.white)
            }
        }
        .padding(24)
    }
}

