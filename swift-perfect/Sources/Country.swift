//
//  Country.swift
//  Swift-API
//
//  Created by Ciprian Redinciuc on 07/10/2017.
//

import Foundation
import StORM
import MySQLStORM

class Country: MySQLStORM {
    internal static let kIso = "iso"
    internal static let kName = "name"
    internal static let kNiceName = "nicename"
    internal static let kIso3 = "iso3"
    internal static let kNumcode = "numcode"
    internal static let kPhoneCode = "phonecode"

    var id: Int = 0
    var name: String = ""
    var nicename: String = ""
    var iso3: String = ""
    var numcode: Int = 0
    var phonecode: Int = 0
    
    override open func table() -> String {
        return "country"
    }
    
    override func to(_ this: StORMRow) {
        id = this.data["id"] as? Int ?? 0
        name = this.data[Country.kName] as? String ?? ""
        nicename = this.data[Country.kNiceName] as? String ?? ""
        iso3 = this.data[Country.kIso3] as? String ?? ""
        numcode = this.data[Country.kNumcode] as? Int ?? 0
        phonecode = this.data[Country.kPhoneCode] as? Int ?? 0
    }
}
