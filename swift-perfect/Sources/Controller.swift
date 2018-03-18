//
//  Controller.swift
//  Swift-API
//
//  Created by Ciprian Redinciuc on 08/10/2017.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

final class Controller {
    var routes: [Route] {
        return [
            Route(method: .get, uri: "hello", handler: helloWorld),
            Route(method: .get, uri: "compute", handler: compute),
            Route(method: .get, uri: "countries", handler: getAllCountries)
        ]
    }

    func helloWorld(request: HTTPRequest, response: HTTPResponse) {
        let outcome = ControllerAPI.helloWorld()
        response.handle(outcome: outcome)
    }

    func compute(request: HTTPRequest, response: HTTPResponse) {
        let outcome = ControllerAPI.compute()
        response.handle(outcome: outcome)
    }

    func getAllCountries(request: HTTPRequest, response: HTTPResponse) {
        let outcome = ControllerAPI.getAllCountries()
        response.handle(outcome: outcome)
    }
}
