//
//  PokemonListPage.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//


import SwiftUI
import Shared
import PokemonDetails
import MyPokemonList

public struct PokemonListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject public var presenter: PokemonListPresenter

    public init(presenter: PokemonListPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        NavigationView {
            List(presenter.pokemonList, id: \.name) { pokemon in
                let interactor = PokemonDetailsInteractor(pokemon: pokemon, viewContext: viewContext)
                let presenter = PokemonDetailsPresenter(interactor: interactor)
                NavigationLink(destination: PokemonDetailsView(presenter: presenter)) {
                    PokemonListRowView(name: pokemon.name, imageUrl: pokemon.imageUrl)
                }
            }
            .onAppear(perform: {
                presenter.loadData()
            })
            .navigationTitle("Pokemon List")
            .navigationBarItems(trailing: NavigationLink(
                destination: MyPokemonListView(presenter: MyPokemonListPresenter(interactor: MyPokemonListInteractor(viewContext: viewContext))),
                label: {
                    Text("My Pokemon")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            ))
        }
    }
}

