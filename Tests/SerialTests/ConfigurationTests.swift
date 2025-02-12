// ConfigurationTests.swift
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

/// Test suite for the `Configuration` type.
@Suite
struct ConfigurationTests {

    /// A test `mode`.
    let mode = FileMode.readWrite

    /// A test `parity`.
    let parity = Parity.none

    /// A test `baudRate`.
    let baudRate = BaudRate.predefined(value: .baud115200)

    /// A test `dataBits`.
    let dataBits: UInt32 = 8

    /// A test `stopBits`.
    let stopBits: UInt32 = 1

    /// A test `hardwareFlowControl`.
    let hardwareFlowControl = HardwareFlowControl.none

    /// A test `useSoftwareFlowControl`.
    let useSoftwareFlowControl = false

    /// A test `Configuration`.
    var configuration: Configuration {
        Configuration(
            mode: mode,
            parity: parity,
            baudRate: baudRate,
            dataBits: dataBits,
            stopBits: stopBits,
            hardwareFlowControl: hardwareFlowControl,
            useSoftwareFlowControl: useSoftwareFlowControl
        )
    }

    /// Test the stored properties are initialised correctly.
    @Test
    func testPropertyInit() {
        let configuration = self.configuration
        #expect(configuration.mode == mode)
        #expect(configuration.parity == parity)
        #expect(configuration.baudRate == baudRate)
        #expect(configuration.dataBits == dataBits)
        #expect(configuration.stopBits == stopBits)
        #expect(configuration.hardwareFlowControl == hardwareFlowControl)
        #expect(configuration.useSoftwareFlowControl == useSoftwareFlowControl)
    }

    /// Test C Type creation.
    @Test
    func testCTypeConversion() {
        let configuration = self.configuration.ctype
        #expect(configuration.mode == mode.ctype)
        #expect(configuration.parity == parity.ctype)
        #expect(configuration.baud_rate.baud_rate.predefined == baudRate.ctype.baud_rate.predefined)
        #expect(configuration.data_bits == dataBits)
        #expect(configuration.stop_bits == stopBits)
        #expect(configuration.hardware_flow_control == hardwareFlowControl.ctype)
        #expect(configuration.use_software_flow_control == useSoftwareFlowControl)
    }

    /// Test intiialisation from the underlying C type.
    @Test
    func testCTypeInitialisation() {
        let configuration = Configuration(ctype: self.configuration.ctype)
        #expect(configuration.mode == mode)
        #expect(configuration.parity == parity)
        #expect(configuration.baudRate == baudRate)
        #expect(configuration.dataBits == dataBits)
        #expect(configuration.stopBits == stopBits)
        #expect(configuration.hardwareFlowControl == hardwareFlowControl)
        #expect(configuration.useSoftwareFlowControl == useSoftwareFlowControl)
        #expect(configuration == self.configuration)
    }

}
