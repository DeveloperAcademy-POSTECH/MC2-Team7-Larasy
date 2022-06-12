//
//  ListView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct ListView: View {
    
    @State var isLighting : Bool = true
    
    var body: some View {
        ZStack{
            Image("lampTop")
                .blur(radius: isLighting ? 25 : 0)
                .padding(.bottom,50)
            Image("lamp")
        }.onTapGesture {
            isLighting.toggle()
        }
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
