//
//  StarRating.swift
//  RandomTeam
//
//  Created by Алексей Рощин on 18.10.2023.
//
import SwiftUI

struct StarRating: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}
