//
//  
//
//
//  Created by Josh Guiang on 3/31/24.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    
}
