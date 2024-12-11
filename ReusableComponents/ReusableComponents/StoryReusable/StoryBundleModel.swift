//
//  StoryBundleModel.swift
//  ReusableComponents
//
//  Created by Shohruhmirzo Alijonov on 10/12/24.
//
import Foundation
import SwiftUI

struct StoryBundle {
    let id: String
    let title: String
    let backgroundImage: Image
    let gradientColors: [Color]
    let participantImage: Image
    let date: Date
    let duration: Double // Duration in minutes
    var isSeen: Bool = false
    var storiesCount: Int = 6
    let url: String
    
    let summary: PulseSummary
    let personalSummary: PersonalSummary
    let sentimentSummary: SentimentSummary
    let strategicTopics: StrategicTopics
    let followups: Followups
    
    mutating func updateStatus(_ seen: Bool) {
        isSeen = seen
    }
    
}

extension StoryBundle: Equatable, Hashable, Identifiable {
    static func == (lhs: StoryBundle, rhs: StoryBundle) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(date)
        hasher.combine(isSeen)
        hasher.combine(storiesCount)
    }
}

//extension StoryBundle {
//    static var test: StoryBundle { StoryBundle.data.first! }
//}

extension StoryBundle {
    var endTime: Date {
        Calendar.current.date(byAdding: .minute, value: Int(duration), to: date) ?? date
    }
    
    //    var timeRangeText: String {
    //        let startTimeFormatted = DateFormatter.timeWithoutPeriod.string(from: date)
    //        let endTimeFormatted = DateFormatter.timeWithPeriod.string(from: endTime).lowercased() // Convert to lowercase for am/pm
    //        return "\(startTimeFormatted) to \(endTimeFormatted)"
    //    }
}


// Story Cards

/// Story Card # 1
struct PulseSummary {
    let title: String
    let thesis: String
}

/// Story Card # 2
struct PersonalSummary {
    let title: String
    let description: String
}

/// Story Card # 3
struct SentimentSummary {
    let topics: [Topic]
}

/// Story Card # 4
struct StrategicTopics {
    let topics: [Topic]
}

/// Story Card # 5
struct Followups {
    let folloups: [String]
}

struct Topic {
    let thesis: String
    let summary: String
}



extension StoryBundle {
    static var data: [StoryBundle] = [
        StoryBundle(
            id: "1",
            title: "Discuss IDG Requirements and Pilot",
            backgroundImage: Image(""),
            gradientColors: [Color.red, Color.blue],
            participantImage: Image(""),
            date: Date(),
            duration: 45,
            isSeen: false,
            storiesCount: 6,
            url: "https://app.fora.day/meeting/6f9fd79daaf5bbd3d80dd6659934ff52ba0a22b8_345s6qajf8ur2nsp8b6eapemv0",
            summary: PulseSummary(
                title: "Discuss IDG Requirements and Pilot",
                thesis: "Internal team reviewed IDG priorities"
            ),
            personalSummary: PersonalSummary(
                title: "A pilot project to automate report writing and enhance analyst productivity is set for November completion.",
                description: "The project aims to streamline data collection, improve customer interaction tracking, and generate client-facing summaries."
            ),
            sentimentSummary: SentimentSummary(
                topics: [
                    Topic(thesis: "Client-facing summary generation", summary: "The team is confident that they can deliver automated outputs for IDG’s reports."),
                    Topic(thesis: "Ambitious feature scope for pilot", summary: "Implementing all requested features by November appears challenging.")
                ]
            ),
            strategicTopics: StrategicTopics(
                topics: [
                    Topic(thesis: "Client-facing summary generation", summary: "Automation of call notes will streamline the reporting process for analysts."),
                    Topic(thesis: "Tracking analyst-client interactions", summary: "Implementing a system to track interactions will provide insights into analyst performance & engagement.")
                ]
            ),
            followups: Followups(
                folloups: [
                    "Gather and share examples of desired output formats for client-facing summaries.",
                    "Interview analysts to collect insights and examples related to data outputs.",
                    "Create a dashboard or report to effectively present findings from the pilot project."
                ]
            )),
            
            StoryBundle(
                id: "2",
                title: "FORA and Prologis review Top 25 customer use case",
                backgroundImage: Image(".background2"),
                gradientColors: [Color.blue, Color.blue],
                participantImage: Image(".participants2"),
                date: Date(),
                duration: 10,
                isSeen: false,
                storiesCount: 6,
                url: "https://fora.day",
                summary: PulseSummary(
                    title: "FORA and Prologis review Top 25 customer use case",
                    thesis: "Reviewing top 25 customer use cases for improvement opportunities"
                ),
                personalSummary: PersonalSummary(
                    title: "Top 25 customer use cases under review",
                    description: "The review aims to identify opportunities for enhancing customer satisfaction and operational efficiency."
                ),
                sentimentSummary: SentimentSummary(
                    topics: [
                        Topic(thesis: "Customer satisfaction", summary: "Neutral sentiment"),
                        Topic(thesis: "Operational efficiency", summary: "Neutral sentiment")
                    ]
                ),
                strategicTopics: StrategicTopics(
                    topics: [
                        Topic(thesis: "Enhancing customer satisfaction", summary: "Focus on improving key customer use cases."),
                        Topic(thesis: "Operational efficiency", summary: "Identify bottlenecks in top customer interactions and suggest improvements.")
                    ]
                ),
                followups: Followups(
                    folloups: [
                        "Collect data on top customer pain points.",
                        "Schedule follow-up meetings with key customers.",
                        "Develop action plans to address identified issues."
                    ]
                )),
                
                StoryBundle(
                    id: "3",
                    title: "Q4 Roadmap Realignment",
                    backgroundImage: Image(".background2"),
                    gradientColors: [Color.blue, Color.blue],
                    participantImage: Image(".participants3"),
                    date: Date(),
                    duration: 53,
                    isSeen: false,
                    storiesCount: 6,
                    url: "https://fora.day",
                    summary: PulseSummary(
                        title: "Q4 Roadmap Realignment",
                        thesis: "Realigning Q4 goals and priorities for maximum impact"
                    ),
                    personalSummary: PersonalSummary(
                        title: "Q4 Roadmap adjustments",
                        description: "Adjusting priorities to ensure alignment with key business objectives and customer needs."
                    ),
                    sentimentSummary: SentimentSummary(
                        topics: [
                            Topic(thesis: "Business objectives alignment", summary: "Positive sentiment"),
                            Topic(thesis: "Customer needs focus", summary: "Positive sentiment")
                        ]
                    ),
                    strategicTopics: StrategicTopics(
                        topics: [
                            Topic(thesis: "Business objectives", summary: "Ensuring roadmap aligns with strategic goals."),
                            Topic(thesis: "Customer needs", summary: "Prioritizing features that address customer feedback.")
                        ]
                    ),
                    followups: Followups(
                        folloups: [
                            "Confirm alignment with all stakeholders.",
                            "Prepare communication for impacted teams.",
                            "Update roadmap documentation."
                        ]
                    )),
                    StoryBundle(
                        id: "4",
                        title: "Caldwell go live triage",
                        backgroundImage: Image(".background2"),
                        gradientColors: [Color.blue, Color.blue],
                        participantImage: Image(".participants4"),
                        date: Date(),
                        duration: 40,
                        isSeen: false,
                        storiesCount: 6,
                        url: "https://fora.day",
                        summary: PulseSummary(
                            title: "Caldwell go live triage",
                            thesis: "Managing triage for Caldwell's go live event"
                        ),
                        personalSummary: PersonalSummary(
                            title: "Triage for Caldwell go live",
                            description: "Handling issues and ensuring smooth go live for Caldwell project."
                        ),
                        sentimentSummary: SentimentSummary(
                            topics: [
                                Topic(thesis: "Go live challenges", summary: "Negative sentiment"),
                                Topic(thesis: "Issue resolution", summary: "Negative sentiment")
                            ]
                        ),
                        strategicTopics: StrategicTopics(
                            topics: [
                                Topic(thesis: "Go live management", summary: "Addressing key challenges for successful launch."),
                                Topic(thesis: "Issue resolution", summary: "Rapid triage to minimize disruptions.")
                            ]
                        ),
                        followups: Followups(
                            folloups: [
                                "Identify key issues faced during go live.",
                                "Prepare mitigation plans for future events.",
                                "Update stakeholders on resolution progress."
                            ]
                        )),
                        StoryBundle(
                            id: "5",
                            title: "Zack & John Sync",
                            backgroundImage: Image(".background2"),
                            gradientColors: [Color.blue, Color.blue],
                            participantImage: Image(".participants5"),
                            date: Date(),
                            duration: 32,
                            isSeen: false,
                            storiesCount: 6,
                            url: "https://fora.day",
                            summary: PulseSummary(
                                title: "Zack & John Sync",
                                thesis: "Synchronizing between Zack and John on key project items"
                            ),
                            personalSummary: PersonalSummary(
                                title: "Sync meeting between Zack and John",
                                description: "Discussion on key project items and progress updates."
                            ),
                            sentimentSummary: SentimentSummary(
                                topics: [
                                    Topic(thesis: "Project progress", summary: "Neutral sentiment"),
                                    Topic(thesis: "Key items synchronization", summary: "Neutral sentiment")
                                ]
                            ),
                            strategicTopics: StrategicTopics(
                                topics: [
                                    Topic(thesis: "Project progress", summary: "Reviewing key milestones."),
                                    Topic(thesis: "Synchronization", summary: "Ensuring both parties are aligned on next steps.")
                                ]
                            ),
                            followups: Followups(
                                folloups: [
                                    "Share updated timelines with the team.",
                                    "Document key discussion points.",
                                    "Plan next sync meeting."
                                ]
                            )),
                            StoryBundle(
                                id: "6",
                                title: "FORA Onboarding",
                                backgroundImage: Image(".background2"),
                                gradientColors: [Color.blue, Color.blue],
                                participantImage: Image(".participants6"),
                                date: Date(),
                                duration: 24,
                                isSeen: false,
                                storiesCount: 6,
                                url: "https://fora.day",
                                summary: PulseSummary(
                                    title: "FORA Onboarding",
                                    thesis: "Onboarding for FORA initiative"
                                ),
                                personalSummary: PersonalSummary(
                                    title: "FORA onboarding process",
                                    description: "Ensuring smooth onboarding for the FORA initiative."
                                ),
                                sentimentSummary: SentimentSummary(
                                    topics: [
                                        Topic(thesis: "Onboarding experience", summary: "Positive sentiment"),
                                        Topic(thesis: "Team readiness", summary: "Positive sentiment")
                                    ]
                                ),
                                strategicTopics: StrategicTopics(
                                    topics: [
                                        Topic(thesis: "Onboarding process", summary: "Ensuring all participants are well-prepared."),
                                        Topic(thesis: "Team readiness", summary: "Focus on training and preparation.")
                                    ]
                                ),
                                followups: Followups(
                                    folloups: [
                                        "Schedule onboarding sessions.",
                                        "Collect feedback from participants.",
                                        "Provide necessary resources for onboarding."
                                    ]
                                )
                                )
        ]
        }
