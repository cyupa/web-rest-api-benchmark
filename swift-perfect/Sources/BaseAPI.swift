//
//  BaseAPI.swift
//  Swift-API
//
//  Created by Ciprian Redinciuc on 08/10/2017.
//

import Foundation
import MySQLStORM
import StORM
import PerfectHTTP
import PerfectLib

struct RequestOutcome {
    var json: String
    var status: HTTPResponseStatus
}

enum APIErrorCode: UInt {
    case wrongParameters = 400
    case notFound = 404
    case duplicate = 409
    case encodingError = 500
}

extension APIErrorCode: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self.rawValue)
    }
}

class BaseAPI {

    static func createError(string: String, code: APIErrorCode, status: HTTPResponseStatus) -> RequestOutcome {
        let dict = ["error": string, "code" : code] as [String : Any]
        var jsonString: String
        do {
            jsonString = try dict.jsonEncodedString()
        } catch {
            jsonString = "{ \"error\" : \"Could not encode error\", }"
        }
        
        return RequestOutcome(json: jsonString, status: status)
    }

    static func createResponse(dict: [String: Any], status: HTTPResponseStatus) -> RequestOutcome {
        var json: String
        do {
            json = try dict.jsonEncodedString()
        } catch {
            return createError(string: "Could not encode response object",
                               code: .encodingError,
                               status: .internalServerError)
        }

        return RequestOutcome(json: json, status: status)
    }

    static func createResponse(array: [StORM], status: HTTPResponseStatus) -> RequestOutcome {
        var json: String
        var dictObjects = [[String: Any]]()
        for object in array {
            let dict = object.asDataDict()
            dictObjects.append(dict)
        }
        do {
            json = try dictObjects.jsonEncodedString()
        } catch {
            return createError(string: "Could not encode response object",
                               code: .encodingError,
                               status: .internalServerError)
        }

        return RequestOutcome(json: json, status: status)
    }
}

extension HTTPResponse {
    func handle(outcome: RequestOutcome) {
        self.setBody(string: outcome.json)
            .setHeader(.contentType, value: "application/json")
            .completed(status: outcome.status)
    }
}
