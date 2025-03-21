//
//  AddEditTimerView.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import SwiftUI

struct AddEditTimerView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var timerManager: TimerManager
    @State private var title: String = ""
    @State private var durationMinutes: String = ""

    var editingTimer: TimerItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(editingTimer == nil ? "Add Timer" : "Edit Timer")
                .font(.title2)
                .padding(.bottom, 8)

            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Duration (minutes)", text: $durationMinutes)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Spacer()
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Button(editingTimer == nil ? "Add" : "Save") {
                    if let minutes = Double(durationMinutes) {
                        let duration = minutes * 60
                        if let editing = editingTimer {
                            timerManager.editTimer(editing, newTitle: title, newDuration: duration)
                        } else {
                            timerManager.addTimer(title: title, duration: duration)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }.disabled(title.isEmpty || Double(durationMinutes) == nil)
            }
        }
        .padding()
        .frame(width: 300)
        .onAppear {
            if let editing = editingTimer {
                title = editing.title
                durationMinutes = String(Int(editing.duration / 60))
            }
        }
    }
}
