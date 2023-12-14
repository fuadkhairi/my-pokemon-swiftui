//
//  RenameSheetView.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import SwiftUI
import Shared

struct RenameSheetView: View {
    @ObservedObject var presenter: MyPokemonListPresenter
    @Binding var selectedPokemon: MyPokemon?
    @Binding var newNickname: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Nickname", text: $newNickname)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Rename") {
                    presenter.renamePokemon(pokemon: selectedPokemon, newNickname: newNickname)
                    selectedPokemon = nil
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("Rename Pokemon")
            .navigationBarItems(trailing: Button("Cancel") {
                selectedPokemon = nil
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
