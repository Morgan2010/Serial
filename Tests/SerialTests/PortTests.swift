// PortTests.swift
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
@testable import Serial
import Testing

/// Test suite for the `Port` type.
@Suite
class PortTests {

    /// A helper file manager.
    let manager: FileManager

    /// The location of the port on the file system.
    let location: URL

    /// A file handle to the open port at `location`.
    let openPort: HANDLE_TYPE

    /// Create port before every test.
    init() throws {
        let location = try #require(Bundle.module.url(forResource: "port", withExtension: nil))
        let manager = FileManager.default
        if manager.fileExists(atPath: location.path) {
            try manager.removeItem(at: location)
        }
        try #require(manager.createFile(atPath: location.path, contents: nil, attributes: nil))
        let openPort = HANDLE_TYPE(open(location.path.cString(using: .utf8) ?? [0], O_RDONLY))
        try #require(openPort >= 0)
        self.location = location
        self.openPort = openPort
        self.manager = manager
    }

    /// Test init sets stored properties correctly.
    @Test
    func testInit() {
        let port = Port(handle: openPort)
        #expect(port.handle == openPort)
    }

    /// Test `bytesAvailable` returns the correct amount.
    @Test
    func testBytesAvailable() throws {
        let port = Port(handle: openPort)
        #expect(try port.bytesAvailable == 0)
        try "123".write(to: self.location, atomically: true, encoding: .utf8)
        let bytes = try port.bytesAvailable
        #expect(bytes == 3)
    }

    /// Close port after every test.
    deinit {
        close(Int32(self.openPort))
    }

}

/// Add helper for c error messages.
extension String {

    /// An error message with the errno converted to a string.
    static var cerrorMessage: String {
        strerror(errno).flatMap { String(cString: $0, encoding: .utf8) } ?? "Unknown error"
    }

}
