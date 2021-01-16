//
//  WordOfTheDayWidgetProvider.swift
//  WordOfTheDay
//
//  Created by Kyle Dold on 15/01/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct WordOfTheDayWidgetProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> WordOfTheDayEntry {
        WordOfTheDayEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WordOfTheDayEntry) -> ()) {
        let entry = WordOfTheDayEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WordOfTheDayEntry>) -> ()) {
        var entries: [WordOfTheDayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WordOfTheDayEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}