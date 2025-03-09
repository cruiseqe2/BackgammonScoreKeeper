//
//  DayHorizontalPicker.swift
//  BackgammonScoreKeeper
//
//  Created by Mark Oelbaum on 07/03/2025.
//

import SwiftUI

struct DayHorizontalPicker: View {
    
    struct WeekDayModel: Hashable {
        let date: Date
        let isCurrentDay: Bool
        let isSelected: Bool = false
    }
    
    @State private var scrollIndex: Date? = Date()
    @Binding var selection: Date
    
    private let dateRange: ClosedRange<Date>
    
    init(selection: Binding<Date>, in dateRange: ClosedRange<Date>) {
        self._selection = selection
        self.dateRange = dateRange
    }
    
    private var candidateDays: [WeekDayModel] {
        let calendar = Calendar.current
        var days: [WeekDayModel] = []
        
        var currentDate = calendar.startOfDay(for: dateRange.lowerBound)
        
        while currentDate <= calendar.startOfDay(for: dateRange.upperBound) {
            let isCurrentDay = calendar.isDate(currentDate, inSameDayAs: calendar.startOfDay(for: Date()))
            
            let dayModel = WeekDayModel(date: currentDate, isCurrentDay: isCurrentDay)
            days.append(dayModel)
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return days
    }
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(candidateDays, id: \.date) { dayModel in
                        weekdayItemView(
                            date: dayModel.date,
                            isSelected: dayModel.date == selection,
                            isCurrentDay: dayModel.isCurrentDay
                        )
                        .id(dayModel.date)
                        .containerRelativeFrame(.horizontal, count: 7, span: 1, spacing: 0)
                        .animation(.smooth, value: selection)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollIndex)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollBounceBehavior(.basedOnSize)
            .onChange(of: selection, initial: true) { oldValue, newValue in
                if oldValue == newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        if let currentDayItem = candidateDays.first(where: { $0.isCurrentDay }) {
                            selection = currentDayItem.date
                            scrollViewProxy.scrollTo(currentDayItem.date, anchor: .center)
                        }
                    }
                }
            }
        }
        .frame(height: 80)
    }
    
    @ViewBuilder
    func weekdayItemView(date: Date, isSelected: Bool = false, isCurrentDay: Bool = false) -> some View {
        let dayNumber = Calendar.current.component(.day, from: date)
        let isWeekend = Calendar.current.component(.weekday, from: date) == 1 || Calendar.current.component(.weekday, from: date) == 7
        
        VStack {
            // Day name
            Text(date, format: .dateTime.weekday(.abbreviated))
                .font(.caption)
                .foregroundStyle(isWeekend ? .red : .secondary)
            
            Spacer()
            
            // Day number
            Group {
                switch (isSelected, isCurrentDay) {
                case (true, _): // Day selected
                    Circle()
                        .fill(Color.accentColor)
                        .overlay {
                            Text("\(dayNumber)")
                                .foregroundStyle(.white)
                        }
                        .padding(8)
                case (false, true): // Is current day but not selected
                    Circle()
                        .strokeBorder(Color.accentColor, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .overlay {
                            Text("\(dayNumber)")
                                .foregroundStyle(Color.accentColor)
                        }
                        .padding(8)
                default: // Default day
                    Text("\(dayNumber)")
                        .padding()
                        .foregroundStyle(isWeekend ? .red : .primary)
                }
            }
            .onTapGesture {
                selection = date
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        let customStartDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        let customEndDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        
        @State var selectedDate: Date = Date()
        
        var body: some View {
            VStack {
                Text("Horizontal day picker").font(.largeTitle).bold().multilineTextAlignment(.center)
                Text("base for build horizontal day picker").font(.footnote).foregroundStyle(.secondary)
                Spacer()
                Text(selectedDate, format: .dateTime.day().month().year()).font(.footnote).foregroundStyle(.secondary)
                
                DayHorizontalPicker(selection: $selectedDate, in: customStartDate...customEndDate)
                    .accentColor(.green)
                
                Spacer()
                Text("bento.me/codelaby").foregroundStyle(.blue)
            }
        }
    }
    
    return PreviewWrapper()
}
