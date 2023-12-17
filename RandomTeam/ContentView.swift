//
//  ContentView.swift
//  RandomTeam
//
//  Created by Алексей Рощин on 13.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = []

    var body: some View {
        NavigationView {
            HStack {
                NavigationLink(destination: TeamView(players: $players)) {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Создать команду")
                    }
                    .onAppear {
                        loadPlayers()
                    }
                    .frame(width: 150.0, height: 150.0)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
                }
               
                NavigationLink(destination: RandomTeamView()){
                    VStack{
                        Image(systemName: "sportscourt")
                        Text("Создать команду на поле")
                    }.frame(width: 150.0, height: 150.0)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                }
                
            }.fontWeight(.bold)
        }
    }
    
    func loadPlayers() {
        if let savedPlayersData = UserDefaults.standard.data(forKey: "players") {
            let decoder = JSONDecoder()
            if let decodedPlayers = try? decoder.decode([Player].self, from: savedPlayersData) {
                players = decodedPlayers
            }
        }
        // После загрузки данных, проверяем, есть ли игроки, и если нет, добавляем пустого игрока
        if players.isEmpty {
            players.append(Player(name: "", rating: 0))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
