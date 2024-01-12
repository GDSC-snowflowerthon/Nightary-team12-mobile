//
//  iosWidget.swift
//  iosWidget
//
//  Created by 심상현 on 2024/01/12.
//

import WidgetKit
import SwiftUI
import Intents

struct WidgetData: Decodable, Hashable {
    let data: Int
}

struct FlutterEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), widgetData: WidgetData(data:100))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (FlutterEntry) -> Void) {
        let entry = FlutterEntry(date: Date(), widgetData: WidgetData(data: 100))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<FlutterEntry>) -> Void) {
        let sharedDefaults = UserDefaults.init(suiteName: "group.nightary")
        let flutterData = try? JSONDecoder().decode(WidgetData.self, from: (sharedDefaults?.string(forKey: "widgetData")?.data(using: .utf8)) ?? Data())
        
        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = FlutterEntry(date: entryDate, widgetData: flutterData)
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct iOSWidget: Widget {
    let kind: String = "iosWidget"
    
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            iosWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
    }
}

extension View {
    func widgetBackground(_ color:Color) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                color
            }
        } else {
            return background(color)
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct iosWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            if entry.widgetData == nil {
                Text("🌙 정상적인 작동을 위해서는 최소 1회 실행이 필요합니다!")
                    .multilineTextAlignment(.center)
            } else {
                VStack (spacing: 5) {
                    Rectangle()
                        .frame(width: 40, height: 10)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .cornerRadius(4, corners: [.bottomLeft, .bottomRight])
                        .padding(0)
                        .foregroundStyle(Color(hex: 0x363C46))
                    ZStack(
                        alignment: .bottom,
                        content: {
                            Rectangle()
                                .frame(width: 60, height: 100)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 10,
                                        bottomLeadingRadius: 10,
                                        bottomTrailingRadius:10,
                                        topTrailingRadius: 10
                                    )
                                )
                                .padding(0)
                                .foregroundStyle(Color(hex: 0x363C46))
                            
                            Rectangle()
                                .frame(width: 60, height: Double(entry.widgetData!.data))
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 10,
                                        bottomLeadingRadius: 10,
                                        bottomTrailingRadius:10,
                                        topTrailingRadius: 10
                                    )
                                )
                                .padding(0)
                                .foregroundStyle(.green)
                        })
                    Text("\(entry.widgetData!.data)%")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding()
            }
        }
        .widgetBackground(Color(hex: 0x3C3C3C))
    }
}
    
    


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
