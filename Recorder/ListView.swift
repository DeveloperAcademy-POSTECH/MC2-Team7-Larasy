//
//  ListView.swift
//  Recorder
//
//  Created by baek seohyeon on 2022/06/12.
//

import SwiftUI

struct ListView: View {
    
    @State private var isRotated : Bool = false
    
    var animation: Animation {
        Animation.easeInOut(duration: 2)
            //.repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack{
            Button("CD ListView"){
                self.isRotated.toggle()
            }
            Image("HomeCD")
                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                .animation(animation)
                .onTapGesture {
                    isRotated.toggle()
                }
                .offset(x: 30, y: 30)
            Rectangle()
                .frame(width: 200, height: 200)
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
