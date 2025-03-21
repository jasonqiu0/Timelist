//
//  TimerRowView.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import SwiftUI

struct TimerRowView: View {
    @ObservedObject var timer: TimerItem
    var onPause: () -> Void
    var onContinue: () -> Void
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timer.title)
                    .font(.headline)
                Text(timer.formattedTime)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()

            if timer.isPaused {
                Button(action: onContinue) {
                    Image(systemName: "play.fill")
                }.buttonStyle(BorderlessButtonStyle())
            } else {
                Button(action: onPause) {
                    Image(systemName: "pause.fill")
                }.buttonStyle(BorderlessButtonStyle())
            }

            Button(action: onEdit) {
                Image(systemName: "pencil")
            }.buttonStyle(BorderlessButtonStyle())

            Button(action: onDelete) {
                Image(systemName: "trash")
            }.buttonStyle(BorderlessButtonStyle())
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
