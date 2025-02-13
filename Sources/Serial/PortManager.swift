// PortManager.swift
// Serial
//
// Created by Morgan McColl.
// Copyright © 2025 Morgan McColl. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimer in the documentation and/or other materials
//    provided with the distribution.
//
// 3. All advertising materials mentioning features or use of this
//    software must display the following acknowledgement:
//
//    This product includes software developed by Morgan McColl.
//
// 4. Neither the name of the author nor the names of contributors
//    may be used to endorse or promote products derived from this
//    software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// -----------------------------------------------------------------------
// This program is free software; you can redistribute it and/or
// modify it under the above terms or under the terms of the GNU
// General Public License as published by the Free Software Foundation;
// either version 2 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, see http://www.gnu.org/licenses/
// or write to the Free Software Foundation, Inc., 51 Franklin Street,
// Fifth Floor, Boston, MA  02110-1301, USA.

import CSerial
import Foundation

public actor PortManager {

    struct PortReference: Equatable {

        weak var port: Port?

        let configuration: Configuration

    }

    static var ports: [URL: PortReference] = [:]

    public static var openPorts: [URL] {
        self.ports.keys.filter { PortManager.port(location: $0) != nil }
    }

    public static func configuration(at location: URL) -> Configuration? {
        guard let reference = PortManager.ports[location], reference.port != nil else {
            return nil
        }
        return reference.configuration
    }

    public static func port(location: URL) -> Port? {
        PortManager.ports[location]?.port
    }

    public static func open(location: URL, configuration: Configuration) throws -> Port {
        guard location.isLocalFile else {
            throw SerialError.invalidResource
        }
        guard let reference = PortManager.ports[location], let port = reference.port else {
            return try PortManager.openPort(location: location, configuration: configuration)
        }
        guard reference.configuration == configuration else {
            throw SerialError.resourceLocked
        }
        return port
    }

    public static func open(location: String, configuration: Configuration) throws -> Port {
        try PortManager.open(
            location: URL(fileURLWithPath: location, isDirectory: false),
            configuration: configuration
        )
    }

    static func openPort(location: URL, configuration: Configuration) throws -> Port {
        let handle = CSERIAL_open_serial_port(location.path.cString(using: .utf8), configuration.ctype)
        guard handle >= 0 else {
            throw SerialError.cerror
        }
        let port = Port(handle: handle)
        PortManager.ports[location] = PortReference(port: port, configuration: configuration)
        return port
    }

}
