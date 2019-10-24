//
//  DiskUtility.swift
//  Common
//
//  Created by Marius Ilie on 24/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public enum DiskUtilityError: Error {
    case wrongObjectType
}

public class DiskUtility {
    public class func write<T: Codable>(_ object: T, in file: String, secured: Bool = false) throws {
        let archivedObject = NSArchivedObject(value: object)
        
        let fullPath = getDocumentsDirectory().appendingPathComponent(file)
        
        let data = try NSKeyedArchiver.archivedData(withRootObject: archivedObject, requiringSecureCoding: secured)
        try data.write(to: fullPath)
    }

    public class func read<T: Codable>(_ object: T.Type, from file: String, secured: Bool = false) throws -> T {
        let fullPath = getDocumentsDirectory().appendingPathComponent(file)
        let data = try Data(contentsOf: fullPath)
        
        if let archivedObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSArchivedObject,
            let value = archivedObject.valueOf(T.self) {
            return value
        } else {
            throw DiskUtilityError.wrongObjectType
        }
    }
    
    private class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
