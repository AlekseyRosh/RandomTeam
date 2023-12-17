//
//  Player.swift
//  RandomTeam
//
//  Created by Алексей Рощин on 18.10.2023.
//
import SwiftUI

struct Player: Identifiable, Hashable, Codable {
    var id = UUID() // уникальный идентификатор для каждого экземпляра Player
    var name: String
    var rating: Int
}
