// BaudRateTests.swift
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
@testable import Serial
import Testing

/// Test suite for the `BaudRate` type.
@Suite
struct BaudRateTests {

    /// Test C Type conversion for custom baud rates.
    @Test
    func testCustomCTypeConversion() {
        let baudRate = BaudRate.custom(value: 115)
        let ctype = baudRate.ctype
        #expect(ctype.baud_rate.baud_rate == 115)
        #expect(!ctype.is_predefined)
    }

    /// Test C Type conversion for predefined baud rates.
    @Test
    func testPredefinedCTypeConversion() {
        let baudRate = BaudRate.predefined(value: .baud110)
        let ctype = baudRate.ctype
        #expect(ctype.baud_rate.predefined == CSERIAL_110)
        #expect(ctype.is_predefined)
    }

    /// Test C Type initialisation for predefined baud rates.
    @Test
    func testPredefinedCTypeInit() {
        let ctype = CSERIAL_BAUDRATE_TYPE(
            baud_rate: CSERIAL_BaudRate_Union(predefined: CSERIAL_110), is_predefined: true
        )
        let baudRate = BaudRate(ctype: ctype)
        #expect(baudRate == .predefined(value: .baud110))
    }

    /// Test C Type initialisation for custom baud rates.
    @Test
    func testCustomCTypeInit() {
        let ctype = CSERIAL_BAUDRATE_TYPE(
            baud_rate: CSERIAL_BaudRate_Union(baud_rate: 115), is_predefined: false
        )
        let baudRate = BaudRate(ctype: ctype)
        #expect(baudRate == .custom(value: 115))
    }

    /// Test the creation of `BaudRate` from integer literals.
    @Test
    func testIntegerLiteralInit() {
        #expect(BaudRate.predefined(value: .baud110) == 110)
        #expect(BaudRate.custom(value: 115) == 115)
    }

}
