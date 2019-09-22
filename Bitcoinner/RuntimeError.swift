//
//  RuntimeError.swift
//  Bitcoinner
//
//  Created by Matheus Fróes on 22/09/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}
