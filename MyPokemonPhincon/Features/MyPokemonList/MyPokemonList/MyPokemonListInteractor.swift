//
//  MyPokemonListInteractor.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import CoreData
import Shared

public class MyPokemonListInteractor {
    public let viewContext: NSManagedObjectContext

    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

    func deletePokemon(pokemon: MyPokemon) {
        viewContext.delete(pokemon)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func renamePokemon(pokemon: MyPokemon, newNickname: String, newCount: Int) {
        DispatchQueue.main.async {
            if pokemon.nickname == newNickname {
                pokemon.count += 1
                pokemon.postFix = Int16(newCount)
            } else {
                pokemon.count = 0
                pokemon.postFix = 0
            }
            pokemon.nickname = newNickname
            do {
                try pokemon.managedObjectContext?.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func getNewPokemonName(pokemon: MyPokemon, newNickname: String, completion: @escaping (Int?) -> Void) {
        guard let catchPokemonApi = URL(string: "\(Constant.serverLessBaseUrl)/api/renamePokemon?count=\(pokemon.count)") else {
            completion(0)
            return
        }
        
        URLSession.shared.dataTask(with: catchPokemonApi) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RenamePokemon.self, from: data)
                    completion(Int(result.renamed_count))
                } catch {
                    print("Error decoding Pokemon details JSON: \(error)")
                    completion(0)
                }
            }
        }.resume()
    }
    
    func releasePokemon(pokemon: MyPokemon, completion: @escaping (Bool, Int, Bool) -> Void) {
        guard let catchPokemonApi = URL(string: "\(Constant.serverLessBaseUrl)/api/getRandomNumber") else {
            print("link error")
            completion(false, 0, false)
            return
        }
        
        URLSession.shared.dataTask(with: catchPokemonApi) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ReleasePokemon.self, from: data)
                    print("release_pokemon: \(result.value) \(result.is_prime)")
                    completion(result.is_success, result.value, result.is_prime)
                } catch {
                    print("Error decoding Pokemon details JSON: \(error)")
                    completion(false, 0, false)
                }
            }
        }.resume()
    }
}
