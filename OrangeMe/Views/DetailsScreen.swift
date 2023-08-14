//
//  DetailsScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI

struct DetailsScreen: View {
    let article: Article
    var body: some View {
        Link(destination: URL(string: article.url)!) {
            VStack(alignment: .leading, spacing: 15) {
                AsyncImage(url: URL(string: article.urlToImage!), scale: 1.0)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    .cornerRadius(5)
                Text(article.title)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
                Text(article.description)
                    .font(.system(size: 18))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
                Text(article.author ?? "")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.horizontal, 20)
                    .foregroundColor(.secondary)

                HStack {
                    AsyncImage(url: URL(string: article.urlToImage!), scale: 1.0)
                        .frame(width: 40, height: 40)
                        .clipped()
                        .cornerRadius(15)
                        .scaledToFit()
                    VStack(alignment: .leading) {
                        Text(article.source.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        Text("Reporter")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }.padding()
            }
        }

    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(article: Article(source: Source(id: "", name: ""), author: "", title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: ""))
    }
}
