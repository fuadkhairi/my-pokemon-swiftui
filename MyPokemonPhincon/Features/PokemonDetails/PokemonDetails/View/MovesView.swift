//
//  MovesView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI
import Shared

struct MovesView: View {
    var moves: [Move]
    
    var body: some View {
        Section(header: HStack {
            Text("Moves")
                .padding(20)
            Spacer()
        }) {
            List(moves, id: \.move.name) { move in
                Text(move.move.name.capitalized)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
