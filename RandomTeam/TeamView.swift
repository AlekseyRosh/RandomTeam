//
//  TeamView.swift
//  RandomTeam
//
//  Created by Алексей Рощин on 13.08.2023.
//

import SwiftUI

struct TeamView: View {
    @Binding var players: [Player]
    @State private var newPlayerName: String = ""
    @State private var newPlayerRating: Int = 0
    @State private var selectedPlayers: Set<Player> = Set()
    @State private var team1: [Player] = []
    @State private var team2: [Player] = []
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("ФИО", text: $newPlayerName)
                TextField("Рейтинг", value: $newPlayerRating, formatter: NumberFormatter())
                Button("+") {
                    if !newPlayerName.isEmpty {
                        let newPlayer = Player(name: newPlayerName, rating: newPlayerRating)
                        players.append(newPlayer)
                        savePlayers()
                        newPlayerName = ""
                        newPlayerRating = 0
                    }
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.green)
            .cornerRadius(15)
            
            List(players) { player in
                HStack {
                    Text(player.name)
                    Spacer()
                    Image(systemName: selectedPlayers.contains(player) ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            if selectedPlayers.contains(player) {
                                selectedPlayers.remove(player)
                            } else {
                                selectedPlayers.insert(player)
                            }
                        }
                }
            }
            
            Button("Удалить выбранных игроков") {
                players.removeAll { player in
                    selectedPlayers.contains(player)
                }
                selectedPlayers.removeAll()
                savePlayers() // Сохранение игроков после удаления
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.red)
            .cornerRadius(15)
            
            Button("Распределить игроков") {
                team1 = []
                team2 = []
                
                // Распределение только отмеченных игроков
                let playersToDistribute = Array(selectedPlayers).shuffled()
                
                for (index, player) in playersToDistribute.enumerated() {
                    if index % 2 == 0 {
                        team1.append(player)
                    } else {
                        team2.append(player)
                    }
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(15)
            
            VStack(alignment: .leading) {
                Text("Команда 1:")
                ForEach(team1, id: \.self) { player in
                    Text(player.name)
                }
                
                Text("Команда 2:")
                ForEach(team2, id: \.self) { player in
                    Text(player.name)
                }
            }.padding()
        }
        .padding()
    }
    
    // Функция для сохранения игроков в UserDefaults
    func savePlayers() {
        let encoder = JSONEncoder()
        if let encodedPlayers = try? encoder.encode(players) {
            UserDefaults.standard.set(encodedPlayers, forKey: "players")
        }
    }
    
    
    func distributePlayers() {
        let sortedPlayers = players.sorted { $0.rating > $1.rating }
        var team1: [Player] = []
        var team2: [Player] = []
        
        var team1Rating = 0
        var team2Rating = 0
        
        for player in sortedPlayers {
            if team1Rating <= team2Rating {
                team1.append(player)
                team1Rating += player.rating
            } else {
                team2.append(player)
                team2Rating += player.rating
            }
        }
    }
}


