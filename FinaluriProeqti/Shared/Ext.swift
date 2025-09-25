//
//  Ext.swift
//  FinaluriProeqti
//
//  Created by Giorgi Manjavidze on 24.09.25.
//


extension City {
    var countryEmoji: String {
        let base: UInt32 = 127397
        var s = ""
        for v in countryCode.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}