//
//  NewsListScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI

struct NewsListScreen: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = NewsViewModel(newsAPIService: NewsAPIServiceImp())
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
                        .onChange(of: searchText) { newValue in
                            // search text must contains 3 or more letters to enable search functionality
                            if !newValue.isEmpty && newValue.count > 3{
                                viewModel.searchFor(string: newValue)
                            }
                        }
                }.overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.gray), lineWidth: 1)
                    .foregroundColor(.clear))
                .padding(.all, 10)
                if viewModel.isRefreshing{
                    VStack(alignment: .center) {
                        Spacer()
                        CustomActivityIndicator()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.orange)
                        Spacer()
                    }
                }else{
                    ScrollView{
                        LazyVStack(spacing: 15){
                            ForEach(viewModel.news, id: \.publishedAt) { newsData in
                                NavigationLink {
                                    DetailsScreen(article: newsData)
                                } label: {
                                    NewsCell(title: newsData.title, source: newsData.source.name, imageUrl: newsData.urlToImage)
                                }
                            }
                        }
                    }.padding(.horizontal, 15)
                        .scrollDismissesKeyboard(.interactively)
                }
            }
            .onAppear{
//                viewModel.fetchNews()
                viewModel.displayNews()
            }
        }
    }
}


struct NewsCell: View {
    var title: String
    var source: String
    var imageUrl: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: imageUrl ?? ""), scale: 1.0)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                .clipped()
                .cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1))
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 20)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
            Text(source)
                .font(.system(size: 12, weight: .light))
                .padding(.horizontal, 20)
                .foregroundColor(.secondary)
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
