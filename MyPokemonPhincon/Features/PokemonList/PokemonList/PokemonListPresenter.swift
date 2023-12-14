//
//  PokemonListPresenter.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import Shared

public class PokemonListPresenter: ObservableObject {
    @Published var pokemonList: [Pokemon] = []

    public let interactor: PokemonListInteractor

    public init(interactor: PokemonListInteractor) {
        self.interactor = interactor
    }

    func loadData() {
        interactor.fetchPokemonList { [weak self] pokemonList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pokemonList = pokemonList

                for index in 0..<self.pokemonList.count {
                    self.fetchPokemonDetails(index: index)
                }
            }
        }
    }

    func fetchPokemonDetails(index: Int) {
        guard index < pokemonList.count else {
            return
        }

        let pokemon = pokemonList[index]

        interactor.fetchPokemonDetails(url: pokemon.url) { [weak self] details in
            guard let self = self, let details = details else { return }
            DispatchQueue.main.async {
                self.pokemonList[index].imageUrl = details.sprites.front_default
            }
        }
    }
}

