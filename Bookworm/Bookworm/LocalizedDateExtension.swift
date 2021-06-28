//
//  LocalizedDateExtension.swift
//  Bookworm
//
//  Created by Johnny Wellington on 27/06/21.
//

import Foundation


extension Date {
    
    func localized() -> String {
        let formatter = DateFormatter()
        let localeIdentifier = UserDefaults.standard.object(forKey: "locale") ?? "pt_BR"
        formatter.locale = Locale(identifier: localeIdentifier as! String)
        formatter.dateStyle = .full
        return formatter.string(from: self)
    }
}
