//
//  String+Extensions.swift
//  Record
//
//  Created by 이지원 on 2023/07/09.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
