//
//  Screenshot.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/15.
//

import SwiftUI

// MARK: - 이미지 저장 기능을 위한 확장
extension View {
    
    func screenshot() -> UIImage {
    
        var image: UIImage?
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        guard let currentView = windowScenes?.windows.first(where: { $0.isKeyWindow })?.layer else { return UIImage() }
        let screenScale = UIScreen.main.scale

        // image capture
        UIGraphicsBeginImageContextWithOptions(currentView.frame.size, false, screenScale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
        currentView.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // crop image
        let cropRect: CGRect = .init(origin: CGPoint(x: 0, y: 250), size: CGSize(width: 1500 , height: 2000))
        let imageRef = image!.cgImage!.cropping(to: cropRect);
        let newImage = UIImage(cgImage: imageRef!, scale: image!.scale, orientation: image!.imageOrientation)
        
        return newImage
    }
}
