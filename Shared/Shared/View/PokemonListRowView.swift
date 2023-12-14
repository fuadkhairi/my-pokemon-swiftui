//
//  PokemonListRowView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI

public struct PokemonListRowView: View {
    public let name: String
    public let imageUrl: String?
    
    public init(name: String, imageUrl: String?) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
    public var body: some View {
        HStack {
            if let imageUrl = imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            Text(name)
        }
    }
}


