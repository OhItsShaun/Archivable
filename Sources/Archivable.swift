//
//  MessageSerialization.swift
//  House
//
//  Created by Shaun Merchant on 14/08/2016.
//  Copyright © 2016 Shaun Merchant. All rights reserved.
//

import Foundation

/// # Data Serialisation
/// `Archivable` transforms objects or values into a serialised format for transmission across networks or writing to disk for storage.
///
/// ## Overview
/// Conformants of `Archivable` guarantee transformation of their object or value into a serialised format, which may be
/// deserialised by the respective conformant of `Unarchivable`.
///
/// If a type cannot guarantee serialisation it **must not** conform to Archivable.
///
/// ## Relexivity
/// A type that conforms to both `Archivable` and `Unarchivable` within the same binary **must** hold reflexivity.
/// For example, if `Int(1)` is archived and subsequently unarchived `Int(1)` must be produced. Similarly, any value 
/// of type `Int` or type `T` which conforms to both `Archivable` and `Unarchivable` must satisfy:
///
/// ```
/// let reflexive = T.unarchive(t.archive())! == t      // must hold true for any value of T
/// ```
///
/// To provide a more concrete example:
///
/// ```
/// let one = 1
/// let archivedOne = 1()
/// let unarchivedOne = Int.unarchive(archivedOne)
/// print(one == unarchivedOne) // true
/// ```
///
/// It is important to note the property of reflexivity is only required of types that conform to both `Archivable` and `Unarchivable`
/// within the same binary. When data needs to be serialised for transmission across networks and delivered to unknown binaries
/// it may not be possible for them to hold reflexivity, e.g.: due to type erasure. Therefore it is permissable for one type to
/// conform to only `Archivable` and a second type to conform to only `Unarchivable`. There is no requirement of reflexivity in this 
/// case.
///
/// ## Expected Performance
/// Conformants should provide serialiased representations promptly to reduce the time taken for requests to be fulfilled across
/// the House network. However, consideration should also be given to encoding used to serialise data. If a particular encoding
/// takes longer to serialise but produces a value with a substantially smaller memory footprint, it may be an appropriate trade-off.
/// It is for conformats to leverage encoding memory footprint against speed of serialisation.
public protocol Archivable {
    
    /// Create a serialised representation of the object instance or value.
    ///
    /// - Returns: A collection of bytes that is a serialised representation of the object instance or value
    func archive() -> Data
    
}

/// # Data Deserialisation
/// `Unarchivable` attempts to transform a stream of bytes into an instance of an object or value.
///
/// ## Overview
/// Conformants of `Unarchivable` attempt transformation of a stream of bytes to an instance, or value.
/// Types that conform to `Unaarchivable` must be prepared to handle byte streams that cannot be fully 
/// deserialised and fail gracefully.
///
///
/// ## Reflexivity
/// A type that conforms to both `Archivable` and `Unarchivable` within the same binary **must** hold reflexivity.
/// For example, if `Int(1)` is archived and subsequently unarchived `Int(1)` must be produced. Similarly, any value
/// of type `Int` or type `T` which conforms to both `Archivable` and `Unarchivable` must satisfy:
/// ```
/// let reflexive = T.unarchive(t.archive())! == t      // must hold true for any value of T
/// ```
///
/// To provide a more concrete example:
/// ```
/// let one = 1
/// let archivedOne = 1()
/// let unarchivedOne = Int.unarchive(archivedOne)
/// print(one == unarchivedOne) // true
/// ```
///
/// It is important to note the property of reflexivity is only required of types that conform to both `Archivable` and `Unarchivable`
/// within the same binary. When data needs to be serialised for transmission across networks and delivereed to unknown binaries
/// it may not be possible for them to hold reflexivity, e.g.: due to type erasure. Therefore it is permissable for one type to
/// conform to only `Archivable` and a second type to conform to only `Unarchivable`. There is no requirement of reflexivity in this
/// case.
public protocol Unarchivable {

    /// Deserialise a collection of bytes into an instance or value of the conforming type.
    ///
    /// - Important: Conformants must be prepared to handle byte streams that cannot be fully deserialised, returning `nil` in this event. 
    /// If a type can deserialise **some**, but not all, of the data to an instance or value it may be appropriate to return the partial 
    /// deserialisation instead of nil, however conformants must make it clear this possibility could occur. 
    ///
    /// - Parameter data: The collection of bytes to deserialise.
    /// - Returns: An instance or value of the conforming type, `nil` if deserialisation could not be completed.
    static func unarchive(_ data: Data) -> Self?
    
}
