//
//  
//
//
//  Created by Josh Guiang on 3/29/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    let apiKey = "eb7108ea888a40d3a3aae9e1712d3dab"
   
    
    func fetchRecipes(ingredients: String) {
        let query = ingredients.replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(query)&number=10&apiKey=\(apiKey)") else {
            print("Invalid URL.")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Data is nil.")
                return
            }

            do {
                let fetchedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}
