//
//  PokemonListInteractor.swift
//  MyPokemonPhincon
//
//  Created by Fuad Khairi Hamid on 14/12/23.
//

import Foundation
import Shared

public class PokemonListInteractor {
    
    public init() {
    
    }
    
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    completion(result.results)
                } catch {
                    print("error fetching.. \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    func fetchPokemonDetails(url: String, completion: @escaping (PokemonDetails?) -> Void) {
        guard let detailsUrl = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: detailsUrl) { data, response, error in
            if let data = data {
                do {
                    let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                    completion(details)
                } catch {
                    print("Error decoding Pokemon details JSON: \(error)")
                }
            }
        }.resume()
    }
}

