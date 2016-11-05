//
//  main.swift
//  publish
//
//  Created by Stephen Brimhall on 11/4/16.
//
//

import Foundation;
import Socks;

let address = InternetAddress.localhost(port: 12345);

do {
    let client = try TCPClient(address: address);
    try client.send(bytes: [0]);
    try client.close();
} catch {
    print("Error contacting publish daemon. Check it is running.");
}
