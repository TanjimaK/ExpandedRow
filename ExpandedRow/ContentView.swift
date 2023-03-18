//
//  ContentView.swift
//  ExpandedRow
//
//  Created by tanjima on 18/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataSource = RecipeListDataSource()
    var body: some View {
        NavigationView {
            List(dataSource.rowModels) { model in
                RecipeRow(model: model)
                
            }
            .navigationTitle("Recipe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RecipeRow: View {
    @State var model : RecipeModule
    var body: some View {
        VStack(alignment: .leading) {
            Button(action:  {
                self.model.isExpanded.toggle()
            }) {
                Text(model.name)
                    .lineLimit(nil)
            }
            if model.isExpanded {
                Text(model.details)
                    .font(.title)
                    .lineLimit(nil)
            }else {
                EmptyView()
            }
                
        }
    }
}

struct RecipeModule: Identifiable {
    var id = UUID().uuidString
    var name: String
    var details:String
    var isExpanded: Bool
}

class RecipeListDataSource : ObservableObject {
    var willChange = ObjectWillChangePublisher()
    
    var rowModels = [RecipeModule](){
        didSet {
            willChange.send()
        }
    }
    
    init() {
        addNewModel(withName: "Maple French Toast", details: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
        
        addNewModel(withName: "Stack-o-Pancakes", details: "What do you get? Pancakes! How many do you get? One metric stack! That's equivalent to 1000 millistacks, or a tenth of a kilostack. In short, you get a lot of pancakes.")
        
        addNewModel(withName: "Power Muesli", details: "Is normal muesli too boring? Of course it is. That's why we serve power muesli – it's like regular muesli, except we put the word \"power\" in front of it so we can charge more.")
    }
    
    private func addNewModel(withName name: String , details: String) {
        let model = RecipeModule(name: name, details: details, isExpanded: false)
        rowModels.append(model)
    }
}
