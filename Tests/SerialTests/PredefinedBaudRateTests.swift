// PredefinedBaudRateTests.swift
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

/// A test suit for the `PredifinedBaudRate` type.
@Suite
struct PredefinedBaudRateTests {

    /// Test that the underlying C type is created correctly.
    @Test
    func testCTypeConversion() {
        #expect(PredefinedBaudRate.baud110.ctype == CSERIAL_110)
        #expect(PredefinedBaudRate.baud300.ctype == CSERIAL_300)
        #expect(PredefinedBaudRate.baud600.ctype == CSERIAL_600)
        #expect(PredefinedBaudRate.baud1200.ctype == CSERIAL_1200)
        #expect(PredefinedBaudRate.baud2400.ctype == CSERIAL_2400)
        #expect(PredefinedBaudRate.baud4800.ctype == CSERIAL_4800)
        #expect(PredefinedBaudRate.baud9600.ctype == CSERIAL_9600)
        #expect(PredefinedBaudRate.baud14400.ctype == CSERIAL_14400)
        #expect(PredefinedBaudRate.baud19200.ctype == CSERIAL_19200)
        #expect(PredefinedBaudRate.baud38400.ctype == CSERIAL_38400)
        #expect(PredefinedBaudRate.baud57600.ctype == CSERIAL_57600)
        #expect(PredefinedBaudRate.baud115200.ctype == CSERIAL_115200)
        #expect(PredefinedBaudRate.baud128000.ctype == CSERIAL_128000)
        #expect(PredefinedBaudRate.baud256000.ctype == CSERIAL_256000)
    }

    /// Test the baud rate can be created from it's C representation.
    @Test
    func testCTypeInitialisation() {
        #expect(PredefinedBaudRate(ctype: CSERIAL_110) == .baud110)
        #expect(PredefinedBaudRate(ctype: CSERIAL_300) == .baud300)
        #expect(PredefinedBaudRate(ctype: CSERIAL_600) == .baud600)
        #expect(PredefinedBaudRate(ctype: CSERIAL_1200) == .baud1200)
        #expect(PredefinedBaudRate(ctype: CSERIAL_2400) == .baud2400)
        #expect(PredefinedBaudRate(ctype: CSERIAL_4800) == .baud4800)
        #expect(PredefinedBaudRate(ctype: CSERIAL_9600) == .baud9600)
        #expect(PredefinedBaudRate(ctype: CSERIAL_14400) == .baud14400)
        #expect(PredefinedBaudRate(ctype: CSERIAL_19200) == .baud19200)
        #expect(PredefinedBaudRate(ctype: CSERIAL_38400) == .baud38400)
        #expect(PredefinedBaudRate(ctype: CSERIAL_57600) == .baud57600)
        #expect(PredefinedBaudRate(ctype: CSERIAL_115200) == .baud115200)
        #expect(PredefinedBaudRate(ctype: CSERIAL_128000) == .baud128000)
        #expect(PredefinedBaudRate(ctype: CSERIAL_256000) == .baud256000)
    }

}
