//
//  TypesView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI
import Shared

struct TypesView: View {
    var types: [Type]
    
    var body: some View {
        Section(header: HStack {
            Text("Types")
                .padding(20)
            Spacer()
        }) {
            List(types, id: \.type.name) { type in
                Text(type.type.name.capitalized)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
