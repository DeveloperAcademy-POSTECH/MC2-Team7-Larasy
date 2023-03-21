//
//  Screenshot.swift
//  Recorder
//
//  Created by 이지원 on 2022/06/15.
//

import SwiftUI

// MARK: - 이미지 저장 기능을 위한 확장
extension View {
    
    //UIView를 캡쳐
    func snapShot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        let size = CGSize(width: 390, height: targetSize.height * 1.2)
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
