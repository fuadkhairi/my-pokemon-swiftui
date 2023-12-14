//
//  PokemonDetailsInteractor.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import CoreData
import Shared

public class PokemonDetailsInteractor {
    let pokemon: Pokemon
    let viewContext: NSManagedObjectContext

    public init(pokemon: Pokemon, viewContext: NSManagedObjectContext) {
        self.pokemon = pokemon
        self.viewContext = viewContext
    }

    func fetchMovesAndTypes(for pokemonName: String, completion: @escaping ([Move], [Type]) -> Void) {
        guard let detailsUrl = URL(string: pokemon.url) else {
            return
        }

        URLSession.shared.dataTask(with: detailsUrl) { data, response, error in
            if let data = data {
                do {
                    let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                    completion(details.moves, details.types)
                } catch {
                    print("Error decoding Pokemon details JSON: \(error)")
                }
            }
        }.resume()
    }

    func addToMyPokemonList(pokemon: Pokemon) {
        let newPokemon = MyPokemon(context: viewContext)
        newPokemon.name = pokemon.name
        newPokemon.url = pokemon.url
        newPokemon.nickname = pokemon.nickname
        newPokemon.imageUrl = pokemon.imageUrl
        newPokemon.dateCreated = Date()

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func tryToCatchPokemon(completion: @escaping (Bool) -> Void) {
        guard let catchPokemonApi = URL(string: "\(Constant.serverLessBaseUrl)/api/getRandomBool") else {
            print("link error")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: catchPokemonApi) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(CatchPokemon.self, from: data)
                    print("cathcpokemon: \(result.value)")
                    completion(result.value)
                } catch {
                    print("Error decoding Pokemon details JSON: \(error)")
                    completion(false)
                }
            }
        }.resume()
    }
}
