//
//  ContentView.swift
//  Fun Math
//
//  Created by Rishal Bazim on 20/02/25.
//

import SwiftUI

struct CardBackGround: View {
    var body: some View {
        LinearGradient(
            stops: [
                .init(color: .teal, location: 0.3),
                .init(color: .cyan, location: 1),
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

struct Questions: Identifiable {
    let id = UUID()
    let num1: Int
    let num2: Int
    var product: Int {
        num1 * num2
    }
}

struct ContentView: View {
    @State private var upToNumber: Int = 2
    @State private var questions: Int = 5
    @State private var questionConfigSet: Bool = false

    @State private var curatedQuestions: [Questions] = []

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
                        Section {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(alignment: .lastTextBaseline, spacing: 0)
                                {
                                    Text("Practice tables up to")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(" \(upToNumber)")
                                        .font(.largeTitle.bold())
                                        .foregroundColor(
                                            .white
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
                                    .foregroundColor(.white)
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
                                setQuestionConfig()
                            } label: {
                                Text("Start")
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                            }.buttonStyle(.borderedProminent).controlSize(
                                .large
                            ).tint(
                                .green
                            )
                        }.listRowBackground(CardBackGround())

                    }.scrollContentBackground(.hidden)
                    List {
                        ForEach(curatedQuestions) { question in
                            Text(
                                "\(question.num1) x \(question.num2) = \(question.product)"
                            )
                        }
                    }
                }
            }.navigationTitle("Fun Maths")
        }
    }

    func setQuestionConfig() {
        curatedQuestions.removeAll()
        for _ in 2...questions {
            let num1 = Int.random(in: 2...upToNumber)
            let num2 = Int.random(in: 2...10)
            curatedQuestions.append(Questions(num1: num1, num2: num2))
        }
        print(curatedQuestions)
    }
}

#Preview {
    ContentView()
}
