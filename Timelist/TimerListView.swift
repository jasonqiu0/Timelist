//
//  TimerListView.swift
//  Timelist
//
//  Created by Jason Qiu on 3/21/25.
//


import SwiftUI

struct TimerListView: View {
    @ObservedObject var timerManager: TimerManager
    @State private var showingAddTimer = false
    @State private var selectedTimerForEdit: TimerItem? = nil

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(timerManager.timers) { timer in
                    TimerRowView(timer: timer,
                                 onPause: { timerManager.pauseTimer(timer) },
                                 onContinue: { timerManager.continueTimer(timer) },
                                 onEdit: { selectedTimerForEdit = timer },
                                 onDelete: { timerManager.deleteTimer(timer) })
                        .padding(.bottom, 4)
                }
            }

            Divider()

            HStack {
                Spacer()
                Button(action: { showingAddTimer = true }) {
                    Label("Add Timer", systemImage: "plus")
                }
                .buttonStyle(LinkButtonStyle())
                .sheet(isPresented: $showingAddTimer) {
                    AddEditTimerView(timerManager: timerManager)
                }
                .sheet(item: $selectedTimerForEdit) { timer in
                    AddEditTimerView(timerManager: timerManager, editingTimer: timer)
                }
                Spacer()
            }
            .padding(.top, 8)
            
            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    NSApp.terminate(nil)
                }) {
                    Text("Quit")
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .padding(.bottom, 4)
        }
        .padding()
        .frame(minWidth: 200, minHeight: 200)
    }
}
