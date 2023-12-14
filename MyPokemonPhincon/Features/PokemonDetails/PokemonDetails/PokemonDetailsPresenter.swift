//
//  PokemonDetailsPresenter.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import SwiftUI
import Shared

public class PokemonDetailsPresenter: ObservableObject {
    @Published var imageUrl: String?
    @Published var name: String
    @Published var nickname: String = ""
    @Published var moves: [Move] = []
    @Published var types: [Type] = []
    @Published var isCatchSuccess: Bool = false
    @Published var showMyPokemonList: Bool = false
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false

    private let interactor: PokemonDetailsInteractor

    public init(interactor: PokemonDetailsInteractor) {
        self.interactor = interactor
        self.name = interactor.pokemon.name
        self.nickname = interactor.pokemon.nickname ?? ""
        self.imageUrl = interactor.pokemon.imageUrl
    }

    func fetchMovesAndTypes() {
        interactor.fetchMovesAndTypes(for: name) { [weak self] moves, types in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.moves = moves
                self.types = types
            }
        }
    }

    func catchPokemon() {
        isLoading = true
        interactor.tryToCatchPokemon(completion: { [weak self] isCatchSuccess in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                self.isCatchSuccess = isCatchSuccess
                if isCatchSuccess {
                    self.showMyPokemonList = true
                }
                self.showAlert = true
            }
        })
    }

    func addToMyPokemonList() {
        var caughtPokemon = Pokemon(name: name, url: interactor.pokemon.url, imageUrl: imageUrl)
        caughtPokemon.nickname = nickname
        interactor.addToMyPokemonList(pokemon: caughtPokemon)
        nickname = ""
        showMyPokemonList = false
    }
}
