//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import MySQLStORM
import PerfectLib

// Create HTTP server.
let server = HTTPServer()
// Set a listen port of 8181
var port: UInt16 = 8181
server.serverPort = port

// Config MySQL
MySQLConnector.host        = "localhost"
MySQLConnector.username    = "root"
MySQLConnector.password    = "Passw0rd-123."
MySQLConnector.database    = "benchmark"
MySQLConnector.port        = 3306

// Register your own routes and handlers
let controller = Controller()

// Add the routes to the server.
server.addRoutes(Routes(controller.routes))

do {
    // Launch the HTTP server.
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
