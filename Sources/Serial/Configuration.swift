// Configuration.swift
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

/// A configuration for a serial port.
public struct Configuration: CTypeConvertible, Equatable, Hashable, Codable, Sendable {

    /// The mode of the port.
    public let mode: FileMode

    /// The parity of the port.
    public let parity: Parity

    /// The baud rate of the port.
    public let baudRate: BaudRate

    /// The number of data bits.
    public let dataBits: UInt32

    /// The number of stop bits.
    public let stopBits: UInt32

    /// The hardware flow control.
    public let hardwareFlowControl: HardwareFlowControl

    /// Whether to use software flow control.
    public let useSoftwareFlowControl: Bool

    /// The C type that represents this configuration.
    @inlinable public var ctype: CSERIAL_CONFIGURATION_TYPE {
        CSERIAL_CONFIGURATION_TYPE(
            mode: mode.ctype,
            parity: parity.ctype,
            baud_rate: baudRate.ctype,
            data_bits: dataBits,
            stop_bits: stopBits,
            hardware_flow_control: hardwareFlowControl.ctype,
            use_software_flow_control: useSoftwareFlowControl
        )
    }

    /// Creates a new configuration from its stored properties.
    /// - Parameters:
    ///   - mode: The mode of the port.
    ///   - parity: The parity of the port.
    ///   - baudRate: The baud rate of the port.
    ///   - dataBits: The number of data bits.
    ///   - stopBits: The number of stop bits.
    ///   - hardwareFlowControl: The hardware flow control.
    ///   - useSoftwareFlowControl: The software flow control.
    @inlinable
    public init(
        mode: FileMode,
        parity: Parity,
        baudRate: BaudRate,
        dataBits: UInt32,
        stopBits: UInt32,
        hardwareFlowControl: HardwareFlowControl,
        useSoftwareFlowControl: Bool
    ) {
        self.mode = mode
        self.parity = parity
        self.baudRate = baudRate
        self.dataBits = dataBits
        self.stopBits = stopBits
        self.hardwareFlowControl = hardwareFlowControl
        self.useSoftwareFlowControl = useSoftwareFlowControl
    }

    /// Conversion init for the underlying C type.
    /// - Parameter ctype: The C type that represents this configuration.
    @inlinable
    public init(ctype: CSERIAL_CONFIGURATION_TYPE) {
        self.init(
            mode: FileMode(ctype: ctype.mode),
            parity: Parity(ctype: ctype.parity),
            baudRate: BaudRate(ctype: ctype.baud_rate),
            dataBits: ctype.data_bits,
            stopBits: ctype.stop_bits,
            hardwareFlowControl: HardwareFlowControl(ctype: ctype.hardware_flow_control),
            useSoftwareFlowControl: ctype.use_software_flow_control
        )
    }

    /// Configure the serial port with 8 data bits, no parity and 1 stop bit.
    /// - Parameter baudRate: The baud rate to configure the port with.
    /// - Returns: A configuration for the serial port.
    @inlinable
    static func configure8N1(baudRate: BaudRate) -> Configuration {
        Configuration(
            mode: .readWrite,
            parity: .none,
            baudRate: baudRate,
            dataBits: 8,
            stopBits: 1,
            hardwareFlowControl: .none,
            useSoftwareFlowControl: false
        )
    }

}
