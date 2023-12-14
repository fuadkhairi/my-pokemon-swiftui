//
//  MyPokemonListPage.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//

import SwiftUI
import CoreData
import Shared
import PokemonDetails

public struct MyPokemonListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MyPokemon.dateCreated, ascending: false)],
        animation: .default)
    var myPokemon: FetchedResults<MyPokemon>
    
    @ObservedObject public var presenter: MyPokemonListPresenter
    
    @State private var selectedPokemon: MyPokemon? = nil
    @State private var isRenameSheetPresented = false
    @State private var newNickname = ""
    
    public init(presenter: MyPokemonListPresenter) {
        self.presenter = presenter
    }
    
    public var body: some View {
        
        ZStack {
            
            List {
                ForEach(myPokemon, id: \.dateCreated) { pokemon in
                    NavigationLink(destination: {
                        PokemonDetailsView(presenter: PokemonDetailsPresenter(interactor: PokemonDetailsInteractor(pokemon: Pokemon(name: pokemon.name ?? "", url: pokemon.url ?? "", imageUrl: pokemon.imageUrl ?? "", nickname: pokemon.nickname ?? ""), viewContext: viewContext)))
                    }) {
                        HStack {
                            if let imageUrl = pokemon.imageUrl {
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
                            if pokemon.count == 0 {
                                Text(pokemon.nickname ?? "")
                            } else {
                                Text("\(pokemon.nickname ?? "")-\(pokemon.postFix)")
                            }
                        }
                        .swipeActions {
                            SwipeActionView(label: "Release") {
                                presenter.tryReleasePokemon(pokemon: pokemon)
                            }
                            SwipeActionView(label: "Rename") {
                                selectedPokemon = pokemon
                                newNickname = selectedPokemon?.nickname ?? ""
                                isRenameSheetPresented.toggle()
                            }
                        }
                        .alert(isPresented: $presenter.showAlert) {
                            Alert(
                                title: Text(presenter.isReleaseSuccess ? "Success!" : "Failed!"),
                                message: Text(presenter.isReleaseSuccess ? "You successfully release a pokemon!" : "Failed to release the pokemon, try again."),
                                dismissButton: .default(Text("OK"), action: {
                                    presenter.showAlert = false
                                })
                            )
                        }
                        .padding()
                    }
                }
            }
            
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0)
            }
        }
        .navigationTitle("My Pokemon List")
        .sheet(isPresented: $isRenameSheetPresented) {
            RenameSheetView(presenter: presenter, selectedPokemon: $selectedPokemon, newNickname: $newNickname)
        }
    }
}


