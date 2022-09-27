//
//  Screenshot.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/15.
//

import SwiftUI

// MARK: - 이미지 저장 기능을 위한 확장
extension View {
    
    //화면에 보이는 그대로를 캡쳐
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
    //UIView를 캡쳐
    func snapShot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        let size = CGSize(width: targetSize.width, height: targetSize.height * 1.2)
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
