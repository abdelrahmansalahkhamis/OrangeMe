//
//  NewsListScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI

struct NewsListScreen: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack {
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                    Text("Searching for \(searchText)")
                        .navigationTitle("Searchable Example")
                }
                Spacer()
            }
        }
        .searchable(text: $searchText)
    }
}

struct NewsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsListScreen()
    }
}
