//
//  Pokemon.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//

import Foundation

public struct PokemonListResponse: Codable {
    public let results: [Pokemon]
}

public struct Pokemon: Codable {
    
    public init(name: String, url: String, imageUrl: String? = nil, nickname: String? = nil) {
        self.name = name
        self.url = url
        self.imageUrl = imageUrl
        self.nickname = nickname
    }
    
    public let name: String
    public let url: String
    public var imageUrl: String?
    public var nickname: String?
}

public struct PokemonDetails: Codable {
    public let sprites: Sprites
    public let moves: [Move]
    public let types: [Type]
    
    public struct Sprites: Codable {
        public let front_default: String
    }
}

public struct Move: Codable {
    public let move: MoveInfo
    
    public struct MoveInfo: Codable {
        public let name: String
    }
}

public struct Type: Codable {
    public let type: TypeInfo
    
    public struct TypeInfo: Codable {
        public let name: String
    }
}
