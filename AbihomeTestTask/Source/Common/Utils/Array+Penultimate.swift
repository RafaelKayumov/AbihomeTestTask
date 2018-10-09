//
//  Array+Penultimate.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 09.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

extension Array {
    var penultimate:Element? {
        return count <= 1 ? nil : self[count-2]
    }
}
