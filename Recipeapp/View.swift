//
//  
//
//
//  Created by Josh Guiang on 3/31/24.
//

import SwiftUI

struct MainInputView: View {
    
    @State private var ingredients = ""
    
    @ObservedObject var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            
            VStack {
                
                Spacer()
                
                Text("Find Recipes using Ingredients")
                    .padding(5)
   
    
                TextField("Ingredients",text: $ingredients)
                    .padding(10)
                    .border(Color.gray)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .fontWeight(.bold)
            
                
                Button("FIND") {
                    viewModel.fetchRecipes(ingredients: ingredients)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
                .padding()
            
                
                
                List(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        HStack {
                            Text(recipe.title)
                            Spacer()
                            Text("\(recipe.usedIngredientCount) ingredients used")
                        }
                        .padding()
                    }
                }
            }
            
            .navigationBarTitle("Recipe", displayMode: .inline)
            .background(Color.blue)
            
            .onAppear {
                            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                                if UIDevice.current.orientation.isLandscape {
                            
                                }
                            }
           
            
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct MainInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainInputView()
        }
    }
}


