//
//  ContentView.swift
//  RecipezTest
//
//  Created by Mark on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var ingredients = [Ingredient(id: "abc12k", text: "Cake")]
    var body: some View {
        List(ingredients, id: \.id) { ingredient in
                    VStack(alignment: .leading) {
                        Text(ingredient.text)
                            .font(.headline)
                        Text(ingredient.id)
                    }
        }.onAppear(perform: {
            loadData()
        })
    }
    
    func loadData() {
        guard let url = URL(string: "http://localhost:3000") else { return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Ingredient].self, from: data) {
                    DispatchQueue.main.async {
                        self.ingredients = decodedResponse
                    }
                    
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
