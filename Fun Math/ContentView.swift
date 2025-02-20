//
//  ContentView.swift
//  Fun Math
//
//  Created by Rishal Bazim on 20/02/25.
//

import SwiftUI


struct ContentView: View {
    @State private var upToNumber: Int = 2
    @State private var questions: Int = 5

    private var questionOptions: [Int] = [5, 10, 15]
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.teal, .green],
                    startPoint: .top,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                VStack {
                    Form {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                Text("Practice tables up to")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(" \(upToNumber)")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(
                                        .teal
                                    )
                            }
                            Stepper(
                                "Up to number",
                                value: $upToNumber,
                                in: 2...12,
                                step: 1
                            )
                            .labelsHidden()
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Choose Difficulty Level")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                            Picker(
                                "Questions",
                                selection: $questions
                            ) {
                                ForEach(questionOptions, id: \.self) {
                                    Text("\($0)")
                                }
                            }.labelsHidden().pickerStyle(.segmented)
                        }

                        Button {
                                
                        }label: {
                            Text("Start")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                        }.buttonStyle(.borderedProminent).controlSize(.large).tint(
                            .green
                        )

                    }.scrollContentBackground(.hidden)

                }
            }.navigationTitle("Fun Maths")
        }
    }
}

#Preview {
    ContentView()
}
