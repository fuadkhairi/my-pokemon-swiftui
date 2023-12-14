//
//  PokemonDetailsPage.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 13/12/23.
//

import SwiftUI
import CoreData

public struct PokemonDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var presenter: PokemonDetailsPresenter
    
    public init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
    }
    
    public var body: some View {
        ZStack {
            
            VStack {
                
                PokemonDefaultInfoView(imageUrl: presenter.imageUrl, name: presenter.name, nickname: presenter.nickname)
                
                MovesView(moves: presenter.moves)
                
                Spacer().frame(height: 16)
                
                TypesView(types: presenter.types)
                
                Spacer().frame(height: 16)
                
                BottomButtonView(presenter: presenter)
            }
            .onAppear(perform: {
                presenter.fetchMovesAndTypes()
            })
            
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0)
            } 
            
            
        }
        .navigationTitle("Details")
    }
}

struct BottomButtonView: View {
    @ObservedObject var presenter: PokemonDetailsPresenter
    var body: some View {
        HStack {
            if presenter.showMyPokemonList {
                VStack {
                    TextField("Enter Nickname", text: $presenter.nickname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        if !presenter.nickname.isEmpty {
                            presenter.addToMyPokemonList()
                        }
                    }) {
                        Text("Add to My Pokemon List")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                }
            } else {
                if presenter.nickname == "" {
                    Button(action: {
                        presenter.catchPokemon()
                    }) {
                        Text("Catch Pokemon")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .alert(isPresented: $presenter.showAlert) {
            Alert(
                title: Text(presenter.isCatchSuccess ? "Success!" : "Failed!"),
                message: Text(presenter.isCatchSuccess ? "You caught the Pokemon!" : "Oops! The Pokemon got away."),
                dismissButton: .default(Text("OK"), action: {
                    presenter.showAlert = false
                })
            )
        }
        .padding()
    }
}

