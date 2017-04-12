//
//  ArchivableFoundations.swift
//  House
//
//  Created by Shaun Merchant on 12/12/2016.
//  Copyright © 2016 Shaun Merchant. All rights reserved.
//

import Foundation

// MARK: - UInt8
extension UInt8: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension UInt8: Unarchivable {
    
    public static func unarchive(_ data: Data) -> UInt8? {
        guard data.isValid(forType: UInt8.self) else {
            return nil
        }
        
        return data.to(type: UInt8.self)
    }
    
}

// MARK: - Float
extension Float: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension Float: Unarchivable {
    
    public static func unarchive(_ data: Data) -> Float? {
        guard data.isValid(forType: Float.self) else {
            return nil
        }
        
        return data.to(type: Float.self)
    }
    
}

// MARK: - UInt16
extension UInt16: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension UInt16: Unarchivable {
    
    public static func unarchive(_ data: Data) -> UInt16? {
        guard data.isValid(forType: UInt16.self) else {
            return nil
        }
        
        
        return data.to(type: UInt16.self)
    }
    
}

// MARK: - UInt64
extension UInt64: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension UInt64: Unarchivable {
    
    public static func unarchive(_ data: Data) -> UInt64? {
        guard data.isValid(forType: UInt64.self) else {
            return nil
        }
        
        return data.to(type: UInt64.self)
    }
    
}

// MARK: - Int
extension Int: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension Int: Unarchivable {
    
    public static func unarchive(_ data: Data) -> Int? {
        guard data.isValid(forType: Int.self) else {
            return nil
        }
        
        return data.to(type: Int.self)
    }
    
}

// MARK: - String
extension String: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension String: Unarchivable {
    
    public static func unarchive(_ data: Data) -> String? {
        return data.to(type: String.self)
    }
    
}

// MARK: - Double
extension Double: Archivable {
    
    public func archive() -> Data {
        return Data(from: self)
    }
    
}

extension Double: Unarchivable {
    
    public static func unarchive(_ data: Data) -> Double? {
        guard data.isValid(forType: Double.self) else {
            return nil
        }
        
        return data.to(type: Double.self)
    }
    
}
extension Date: Archivable {
    
    public func archive() -> Data {
        return Data(from: self.timeIntervalSince1970)
    }
    
}

extension Date: Unarchivable {
    
    public static func unarchive(_ data: Data) -> Date? {
        guard let timeInterval = TimeInterval.unarchive(data) else {
            return nil
        }
        
        return Date(timeIntervalSince1970: timeInterval)
    }
    
}
