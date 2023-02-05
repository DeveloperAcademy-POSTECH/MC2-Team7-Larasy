//
//  URLImage.swift
//  Record
//
//  Created by 이지원 on 2022/12/31.
//

import SwiftUI

/// url string 을 이용해서 image를 불러옵니다.
/// - parameters
/// urlString: 이미지의 url 을 입력해주세요

struct URLImage: View {
    
    let urlString: String

    var body: some View {

        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(.gray)

        } placeholder: {
            Color.titleLightgray
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(urlString: "https://cdn.pixabay.com/photo/2022/01/11/21/48/link-6931554_1280.png")
    }
}
