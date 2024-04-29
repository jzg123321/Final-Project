//
// 
//
//
//  Created by Josh Guiang on 3/31/24.
//

import SwiftUI
import SafariServices

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var showSafari = false
    @State private var recipeCardURL: URL?
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            
            Image("recipeCards")
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
                .frame(width: 175, height: 175)
            
            Text("This App helps users find recipes with various ingredients they have")
                           .padding()
                       
            
            
           
            Button("See Recipe") {
                fetchRecipeCard(for: recipe.id)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
            .padding()

            if showSafari, let url = recipeCardURL {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }


    func fetchRecipeCard(for recipeId: Int) {
        RecipeCardFetcher().fetchRecipeCard(for: recipeId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeCard):
                    self.recipeCardURL = recipeCard.url
                    self.showSafari = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showingErrorAlert = true
                }
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRecipe = Recipe(
            id: 1,
            title: "Sample Recipe",
            image: "sampleRecipeImage",
            usedIngredientCount: 5
            
        )
        
        return RecipeDetailView(recipe: sampleRecipe)
    }
}


    

