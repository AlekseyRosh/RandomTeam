//
//  RandomTeamView.swift
//  RandomTeam
//
//  Created by Алексей Рощин on 13.08.2023.
//
import SwiftUI

struct RandomTeamView: View {
    @State private var totalPlayers: Int = 0
    @State private var currentTeam = 1
    @State private var remainingPlayers: Int = 0

    var body: some View {
        VStack {
            TextField("Общее количество игроков", value: $totalPlayers, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.green)
                .cornerRadius(15)

            Button("Разместить игрока") {
                if remainingPlayers > 0 {
                    currentTeam = currentTeam == 1 ? 2 : 1
                    remainingPlayers -= 1
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(15)

            Text("Команда \(currentTeam)")
                .padding()
            
            Text("Оставшиеся игроки: \(remainingPlayers)")
                .padding()
        }
        .onAppear {
            remainingPlayers = totalPlayers
        }
    }
}
