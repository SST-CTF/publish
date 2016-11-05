//
//  main.swift
//  publish
//
//  Created by Stephen Brimhall on 11/4/16.
//
//

import Foundation;
import Socks;
import SwiftShell;

typealias Byte=UInt8;

let address = InternetAddress.localhost(port: 12345);

// get GIDs for user
let gids = run("id", "-G").toBytes();

do {
    // Try to connect to server
    let client = try TCPClient(address: address);
    // Try to send bytes
    try client.send(bytes: [0] + gids);
    // Save response
    let response = try client.receiveAll();
    if response[0] == 6 {
        print("User is authorized. Publishing website");
    } else if response[0] == 21 {
        print("User is not authorized. Publishing not permitted");
        try client.close();
        exit(2);
    } else if response[0] == 0 {
        print("Invalid command");
        try client.close();
        exit(3);
    } else {
        print("Unexpected response");
        try client.close();
        exit(4);
    }
    // Close connection
    try client.close();
} catch {
    print("Error contacting publish daemon. Check it is running.");
    exit(1);
}
