//
//  File.swift
//  
//
//  Created by Josh Guiang on 4/27/24.
//

import Foundation


struct RecipeCardFetcher {
    let apiKey = "eb7108ea888a40d3a3aae9e1712d3dab"  

    func fetchRecipeCard(for recipeId: Int, completion: @escaping (Result<RecipeCard, Error>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(recipeId)/card?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Error"])))
                return
            }

            do {
                let recipeCard = try JSONDecoder().decode(RecipeCard.self, from: data)
                completion(.success(recipeCard))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct RecipeCard: Codable {
    let url: URL
}
