//
//  Tip.swift
//  Trekr
//
//  Created by Johnny Wellington on 13/04/21.
//

import Foundation

struct Tip: Decodable {
    let text: String
    let children: [Tip]?
}
