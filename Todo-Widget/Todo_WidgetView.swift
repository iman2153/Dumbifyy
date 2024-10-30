//
//  Todo_WidgetView.swift
//  Todo-CoreData-LockScreen
//
//  Created by Kim Insub on 2022/11/01.
//

import SwiftUI
import WidgetKit

struct Todo_WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        // MARK: - LockScreenRectangle
//        case .accessoryCircular:
//            accessoryCircular
        // MARK: - LockScreenRectangle
        case .accessoryRectangular:
            accessoryRectangular
        // MARK: - WidgetSmall
        default:
            systemSmall
        }
    }
}

// MARK: - SubViews
private extension Todo_WidgetEntryView {
//    var accessoryCircular: some View {
//        Gauge(value: calculateGaugeValue()) {
//            Text("TODO")
//        }
//        .gaugeStyle(.accessoryCircularCapacity)
//    }

    var accessoryRectangular: some View {
        Group {
            if entry.inProgressTodos.isEmpty {
                Text("⚠️투두가 비었습니다")
                    .fontWeight(.bold)
            } else {
                VStack {
                    ForEach(validateLenghtForLockscreen(), id: \.self) { todo in
                        HStack(spacing: 2) {
                            Image(systemName: "square")
                                .font(.system(size: 8))
                            Text(todo.title ?? "")
                                .font(.system(size: 12))
                            Spacer()
                        }
                    }
                }
                .padding(.all, 10)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.black)
        .cornerRadius(10)
    }

    @ViewBuilder
    var systemSmall: some View {
        VStack {
            ForEach(validateLenghtForWidget(), id: \.self) { todo in
                Link(destination: URL(string: "todo://todo/\(todo.title ?? "Messages")")!){
                    HStack {
                        Text(todo.title ?? "")
                            .font(.system(size:30))
                            .bold()
                            .colorInvert()
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .opacity(0.8)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#212121"))
        }
    }


// MARK: - Functions
private extension Todo_WidgetEntryView {
    func calculateGaugeValue() -> Float {
        let total = entry.todos.count
        let hasDone = total-entry.inProgressTodos.count
        return Float(hasDone)/Float(total)
    }

    func validateLenghtForLockscreen() -> Array<TodoEntity> {
        if entry.inProgressTodos.count > 2 {
            return Array(entry.inProgressTodos[0...2])
        } else {
            return entry.inProgressTodos
        }
    }

    func validateLenghtForWidget() -> Array<TodoEntity> {
        if entry.inProgressTodos.count > 5 {
            return Array(entry.inProgressTodos[0...5])
        } else {
            return entry.inProgressTodos
        }
    }
}
