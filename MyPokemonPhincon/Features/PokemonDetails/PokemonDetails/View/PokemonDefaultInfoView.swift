//
//  PokemonDefaultInfoView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI

struct PokemonDefaultInfoView: View {
    var imageUrl: String?
    var name: String
    var nickname: String
    
    var body: some View {
        if let imageUrl = imageUrl {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        
        if nickname != "" {
            Text(nickname)
                .font(.title)
            
            Text(name)
                .font(.title3)
        } else {
            Text(name)
                .font(.title)
        }
    }
}
