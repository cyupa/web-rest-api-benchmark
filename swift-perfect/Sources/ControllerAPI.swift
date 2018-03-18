//
//  ControllerAPI.swift
//  Swift-API
//
//  Created by Ciprian Redinciuc on 08/10/2017.
//

import Foundation
import StORM
import MySQLStORM

class ControllerAPI: BaseAPI {


    static func helloWorld() -> RequestOutcome {
        return RequestOutcome(json: "{Hello: World}", status: .accepted)
    }

    static func compute() -> RequestOutcome {
        var x: UInt64 = 0, y: UInt64 = 1
        let max = 10000

        for _ in 0...max {
            let z: UInt64 = x &+ y
            x = y
            y = z
        }

        return RequestOutcome(json: "{status: done }", status: .accepted)
    }

    static func getAllCountries() -> RequestOutcome {
        var response = [[String: Any]]()
        do {
            let searchObject = Country()
            try searchObject.findAll()
            for row in searchObject.results.rows {
                response.append(row.data)
            }
        } catch {
            print("\(error)") //TODO: Must handle
        }

        return createResponse(dict: ["data" : response], status: .accepted)
    }
}
