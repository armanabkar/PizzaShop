//
//  PizzaShopWidget.swift
//  PizzaShopWidget
//
//  Created by Arman Abkar on 8/14/22.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct PizzaShopWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Text(K.Information.appName)
                    .font(.custom(K.Fonts.pizzaHut, size: 26))
                
                Spacer()
                
                Text("Pepperoni Pizza")
                    .font(.footnote)
                    .fontWeight(.semibold)
                HStack {
                    Text("20$")
                        .strikethrough()
                        .font(.callout)
                    Text("12$")
                        .font(.title)
                        .fontWeight(.medium)
                }
            }
            .foregroundColor(.white)
            .padding(.vertical)
        }
    }
}

@main
struct PizzaShopWidget: Widget {
    let kind: String = "PizzaShopWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: ConfigurationIntent.self,
                            provider: Provider()) { entry in
            PizzaShopWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("PizzaShop Widget")
        .description("A widget for PizzaShop to display offers.")
        .supportedFamilies([.systemSmall])
    }
}

struct PizzaShopWidget_Previews: PreviewProvider {
    static var previews: some View {
        PizzaShopWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
