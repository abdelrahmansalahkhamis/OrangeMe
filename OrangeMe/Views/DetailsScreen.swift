//
//  DetailsScreen.swift
//  OrangeMe
//
//  Created by Abdelrahman Salah on 12/08/2023.
//

import SwiftUI

struct DetailsScreen: View {
    var body: some View {
        Link(destination: URL(string: "https://www.apple.com")!) {
            VStack(alignment: .leading, spacing: 15) {
                Image("tomato")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    .cornerRadius(5)
                Text("Google Pixel Phones Getting February 2021 Update with Security Patches")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                Text("Google Pixel Phones are receiving February 2021 security update with few bug fixes and patches for several vulnerabilities,\n The update is available for Pixel 3 and beyond, and is being rolled out in phases, that means not every pixel phone owner will receive it immediately ")
                    .font(.system(size: 18))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)

                Text("Apple Podcasts, Google Podcasts")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.horizontal, 20)

                HStack {
                    Image("tomato")
                        .frame(width: 40, height: 40)
                        .clipped()
                        .cornerRadius(15)
                        .scaledToFit()
                    VStack(alignment: .leading) {
                        Text("Marina Sherof")
                            .font(.system(size: 14, weight: .medium))
                        Text("Reporter")
                            .font(.system(size: 14, weight: .light))
                    }
                    Spacer()
                }.padding()
            }
        }

    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
