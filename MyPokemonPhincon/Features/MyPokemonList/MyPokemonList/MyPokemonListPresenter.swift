//
//  MyPokemonListPresenter.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import CoreData
import SwiftUI
import Shared

public class MyPokemonListPresenter: ObservableObject {
    public let interactor: MyPokemonListInteractor
    
    @Published public var isLoading: Bool = false
    @Published public var isReleaseSuccess: Bool = false
    @Published public var showAlert: Bool = false
    
    public init(interactor: MyPokemonListInteractor) {
        self.interactor = interactor
    }
    
    func tryReleasePokemon(pokemon: MyPokemon) {
        isLoading = true
        interactor.releasePokemon(pokemon: pokemon, completion: { [weak self] success, number, isPrime in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                self.showAlert = true
                if isPrime {
                    self.deletePokemon(pokemon: pokemon)
                    self.isReleaseSuccess = true
                } else {
                    self.isReleaseSuccess = false
                }
            }
        })
    }
    
    func deletePokemon(pokemon: MyPokemon) {
        interactor.deletePokemon(pokemon: pokemon)
    }
    
    func renamePokemon(pokemon: MyPokemon?, newNickname: String) {
        isLoading = true
        guard let pokemon = pokemon else { return }
        
        interactor.getNewPokemonName(pokemon: pokemon, newNickname: newNickname, completion: { [weak self] newCount in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                self.interactor.renamePokemon(pokemon: pokemon, newNickname: newNickname, newCount: newCount ?? 0)
            }
        })
        
    }
}
