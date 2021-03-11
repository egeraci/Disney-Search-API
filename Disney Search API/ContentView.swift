//
//  ContentView.swift
//  Disney Search API
//
//  Created by Student on 3/11/21.
//

import SwiftUI

struct ContentView: View {
   @State private var entrys = [Entry]()
    @State private var showingalert = false
    var body: some View {
        NavigationView
        {
            List(entrys)
            {
                entry in
                Link(destination: URL(string: entry.link)!, label:
                {
                    Text(entry.title)
                })
            }
            .navigationTitle("Disney!")
        }
        .onAppear(perform:
                    {
                        getDisney()
                    })
        .alert(isPresented: $showingalert, content: {
            Alert(title: Text("loading error"), message: Text("There's a problem loading your data"), dismissButton: .default(Text("OK")))
        })
    }
    func getDisney()
    {
        showingalert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Entry: Identifiable
{
    let id = UUID()
    let title: String
    let link: String
    
}
