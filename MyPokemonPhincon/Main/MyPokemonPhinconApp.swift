//
//  MyPokemonPhinconApp.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//

import SwiftUI
import Shared
import PokemonList

@main
struct MyPokemonPhinconApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let interactor = PokemonListInteractor()
            let presenter = PokemonListPresenter(interactor: interactor)
            PokemonListView(presenter: presenter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
