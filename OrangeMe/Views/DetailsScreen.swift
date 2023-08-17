//
//  DetailsScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI
import SafariServices

struct DetailsScreen: View {
    let article: Article

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            AsyncImage(url: URL(string: article.urlToImage ?? ""), scale: 1, content: { image in
                image.resizable()
            }, placeholder: {
                ProgressView()
            })
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
            .clipped()
            .cornerRadius(5)
            .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 15) {
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
                Text("published at: \(dateFormatting(article.publishedAt))")
                    .font(.system(size: 16, weight: .light))
                    .padding(.horizontal, 20)
                    .foregroundColor(.secondary)

                HStack {
                    AsyncImage(url: URL(string: article.urlToImage ?? ""), scale: 1, content: { image in
                        image.resizable()
                    }, placeholder: {
                        ProgressView()
                    })
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

            HStack {
                Spacer()
                Button {
                    if let url = URL(string: article.url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Open in Safari")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }

        }
    }
    private func dateFormatting(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        } else {
            return "Invalid date format"
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(article: Article(source: Source(id: "", name: ""), author: "", title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: ""))
    }
}
