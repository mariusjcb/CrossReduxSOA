//
//  AnyReducible.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

/** Any model used into reducer should implement this protocol.
 - It makes easely to identify models in reducer.
 - Protocol requires at least one identifiable variable in your model.
 - Int, UUID are also identifiable so you can simply store an id: Int or id: UUID to make your model Identifiable. */

public protocol ReducibleObject: Codable { }
