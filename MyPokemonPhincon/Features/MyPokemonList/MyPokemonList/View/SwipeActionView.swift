//
//  SwipeActionView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI


struct SwipeActionView: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
}
