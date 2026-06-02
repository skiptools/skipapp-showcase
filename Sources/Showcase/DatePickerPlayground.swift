// Copyright 2023–2026 Skip
import Foundation
import SwiftUI

struct DatePickerPlayground: View {
    @State var selectedDate = Date.now

    // Date range: next 30 days from now
    var dateRange: ClosedRange<Date> {
        let now = Date.now
        let thirtyDaysLater = Calendar.current.date(byAdding: .day, value: 30, to: now)!
        return now...thirtyDaysLater
    }

    // Date range: past week
    var pastWeekRange: ClosedRange<Date> {
        let now = Date.now
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        return oneWeekAgo...now
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                DatePicker(selection: $selectedDate) {
                    Text("Viewbuilder init")
                }
                DatePicker("String init", selection: $selectedDate)
                VStack {
                    Text(".labelsHidden():")
                    DatePicker("Label", selection: $selectedDate)
                }
                .labelsHidden()

                Divider()

                // Date range examples
                Text("Date Range Examples").font(.headline)

                DatePicker("Next 30 days", selection: $selectedDate, in: dateRange)

                DatePicker("Past week only", selection: $selectedDate, in: pastWeekRange, displayedComponents: .date)

                DatePicker(selection: $selectedDate, in: dateRange) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("ViewBuilder with range")
                    }
                }

                Divider()

                DatePicker(".buttonStyle(.plain)", selection: $selectedDate)
                    .buttonStyle(.plain)
                DatePicker(".disabled(true)", selection: $selectedDate)
                    .disabled(true)
                DatePicker(".foregroundStyle(.red)", selection: $selectedDate)
                    .foregroundStyle(.red)
                DatePicker(".tint(.red)", selection: $selectedDate)
                    .tint(.red)
                DatePicker("Date only", selection: $selectedDate, displayedComponents: .date)
                DatePicker("Time only", selection: $selectedDate, displayedComponents: .hourAndMinute)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "DatePickerPlayground.swift")
        }
    }
}
