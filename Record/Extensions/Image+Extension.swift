//
//  Image+Extension.swift
//  Record
//
//  Created by JeonJimin on 2023/07/12.
//

import SwiftUI

enum RecordImage {
    case backwindow
    case album
    case cdPlayer
    case desk
    case listViewCdPlayer
    case moon
    case note
    case polaroid
    case shelf
    case lylicComp
    case photoComp
    case storyComp
    
    func fetchRecordImage(isLighting: Bool) -> String {
        switch self {
        case .backwindow:
            return isLighting ? "backwindow_dark" : "backwindow"
        case .album:
            return isLighting ? "album_dark" : "album"
        case .cdPlayer:
            return isLighting ? "CdPlayer_dark" : "CdPlayer"
        case .desk:
            return isLighting ? "desk_dark" : "desk"
        case .listViewCdPlayer:
            return isLighting ? "ListViewCdPlayer_dark" : "ListViewCdPlayer"
        case .moon:
            return isLighting ? "moon" : ""
        case .note:
            return isLighting ? "note_dark" : "note"
        case .polaroid:
            return isLighting ? "polaroid_dark" : "polaroid"
        case .shelf:
            return isLighting ? "shelf_dark" : "shelf"
        case .lylicComp:
            return isLighting ? "LylicComp_dark" : "LylicComp"
        case .photoComp:
            return isLighting ? "PhotoComp_dark" : "PhotoComp"
        case .storyComp:
            return isLighting ? "StoryComp_dark" : "StoryComp"
        }
    }
}
