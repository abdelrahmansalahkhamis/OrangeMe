//
//  NewsListScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI

struct NewsListScreen: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = NewsViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "magnifyingglass")
                        .aspectRatio(contentMode: .fill)
                        .padding(.leading, 10)
                    TextField("Search ...", text: $searchText)
                        .frame(height: 45)
                        .padding([.leading, .trailing], 3)
                    Button {

                    } label: {
                        Image("emptyText")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                    }.padding()

                }.overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.gray), lineWidth: 1)
                    .foregroundColor(.clear))
                .padding(.all, 10)
                ScrollView{
                    LazyVStack(spacing: 15){
                        ForEach(viewModel.news, id: \.publishedAt) { _ in
                            NavigationLink {
                                DetailsScreen()
                            } label: {
                                NewsCell()
                            }
                        }
                    }
                }.padding(.horizontal, 10)
                    .scrollIndicators(.never)
            }
            .onAppear{
                viewModel.fetchNews()
            }
        }
    }
}


struct NewsCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("tomato")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                .clipped()
                .cornerRadius(5)
            Text("News are come News are come News are come News are come News are come")
                .padding(.horizontal, 20)
            Spacer()
        }.cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1))

    }
}

struct NewsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsListScreen()
    }
}
