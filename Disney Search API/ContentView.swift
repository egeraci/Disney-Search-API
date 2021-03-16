//
//  ContentView.swift
//  Disney Search API
//
//  Created by Student on 3/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var entries = [Entry]()
    @State private var showingalert = false
    var body: some View {
        NavigationView
        {
            List(entries) {
                entry in
                Link(destination: URL(string: entry.link)!, label: {
                    Text(entry.title)
                })
            }
            .navigationTitle("Disney!")
        }
        .onAppear(perform: {
            getDisney()
        })
        .alert(isPresented: $showingalert, content: {
            Alert(title: Text("loading error"), message: Text("There's a problem loading your data"), dismissButton: .default(Text("OK")))
        })
    }
    
    func getDisney()
    {
        let apiKey = "?rapidapi-key=9ffc0481e6msh0b0a5178fa7b7a1p135476jsn3edbce5e740f"
        let query = "https://google-search3.p.rapidapi.com/api/v1/search/q=disney&num=100\(apiKey)"
        if let url = URL (string:query)
        {
            if let data = try? Data(contentsOf: url)
            {
                let json = try! JSON(data: data)
                let contents = json["resalts"].arrayValue
                for item in contents
                {
                    let title = item["title"].stringValue
                    let link = item ["link"].stringValue
                    let entry = Entry(title: title,link: link)
                    entries.append(entry)
                }
                return
            }
        }
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
