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
    var answer: Int?
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
                if questionConfigSet {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Answer them correctly").font(.headline)
                            ForEach(curatedQuestions.indices, id: \.self) {
                                index in
                                HStack {
                                    Text(
                                        "\(curatedQuestions[index].num1) x \(curatedQuestions[index].num2) = "
                                    )
                                    TextField(
                                        "answers",
                                        value: Binding(
                                            get: {
                                                curatedQuestions[index].answer
                                            },
                                            set: { newValue in
                                                curatedQuestions[index].answer =
                                                    newValue
                                            }
                                        ),
                                        format: .number
                                    )
                                    .keyboardType(.numberPad)
                                }
                            }
                        }.padding().frame(
                            maxWidth: .infinity, alignment: .leading
                        ).background(
                            CardBackGround()
                        ).clipShape(
                            .rect(cornerRadius: 10)
                        )
                    }.padding().shadow(
                        color: .white,
                        radius: 5,
                        x: 0,
                        y: 1
                    )
                } else {
                    VStack {
                        Form {
                            Section {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack(
                                        alignment: .lastTextBaseline, spacing: 0
                                    ) {
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
                                    withAnimation {
                                        questionConfigSet.toggle()
                                    }
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
                        }.scrollContentBackground(.hidden).transition(
                            .push(from: .bottom)
                        ).shadow(
                            color: .white,
                            radius: 5,
                            x: 0,
                            y: 1
                        )
                    }
                }
            }.navigationTitle("Fun Maths").toolbar {
                Button("Quit") {

                }
            }
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
