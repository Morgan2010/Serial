// BaudRate.swift
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

/// A type representing baud rates of a serial port.
///
/// The enum represents both predefined baud rates and custom baud rates.
public enum BaudRate: CTypeConvertible, Equatable, Hashable, Codable, Sendable, ExpressibleByIntegerLiteral {

    /// A custom baud rate.
    case custom(value: UInt32)

    /// A pre-defined baud rate.
    case predefined(value: PredefinedBaudRate)

    /// A 110 baud rate.
    public static let baud110 = BaudRate.predefined(value: .baud110)

    /// A 300 baud rate.
    public static let baud300 = BaudRate.predefined(value: .baud300)

    /// A 600 baud rate.
    public static let baud600 = BaudRate.predefined(value: .baud600)

    /// A 1200 baud rate.
    public static let baud1200 = BaudRate.predefined(value: .baud1200)

    /// A 2400 baud rate.
    public static let baud2400 = BaudRate.predefined(value: .baud2400)

    /// A 4800 baud rate.
    public static let baud4800 = BaudRate.predefined(value: .baud4800)

    /// A 9600 baud rate.
    public static let baud9600 = BaudRate.predefined(value: .baud9600)

    /// A 14400 baud rate.
    public static let baud14400 = BaudRate.predefined(value: .baud14400)

    /// A 19200 baud rate.
    public static let baud19200 = BaudRate.predefined(value: .baud19200)

    /// A 38400 baud rate.
    public static let baud38400 = BaudRate.predefined(value: .baud38400)

    /// A 57600 baud rate.
    public static let baud57600 = BaudRate.predefined(value: .baud57600)

    /// A 115200 baud rate.
    public static let baud115200 = BaudRate.predefined(value: .baud115200)

    /// A 128000 baud rate.
    public static let baud128000 = BaudRate.predefined(value: .baud128000)

    /// A 256000 baud rate.
    public static let baud256000 = BaudRate.predefined(value: .baud256000)

    /// The underlying C type.
    @inlinable public var ctype: CSERIAL_BAUDRATE_TYPE {
        switch self {
        case .custom(let value):
            return CSERIAL_BAUDRATE_TYPE(
                baud_rate: CSERIAL_BaudRate_Union(baud_rate: value),
                is_predefined: false
            )
        case .predefined(let value):
            return CSERIAL_BAUDRATE_TYPE(
                baud_rate: CSERIAL_BaudRate_Union(predefined: value.ctype),
                is_predefined: true
            )
        }
    }

    /// Create a `BaudRate` from it's underlying C type.
    /// - Parameter ctype: The underlying C type to convert into a `BaudRate`.
    @inlinable
    public init(ctype: CSERIAL_BAUDRATE_TYPE) {
        if ctype.is_predefined {
            self = .predefined(value: PredefinedBaudRate(ctype: ctype.baud_rate.predefined))
        } else {
            self = .custom(value: ctype.baud_rate.baud_rate)
        }
    }

    /// Create a `BaudRate` from an integer literal.
    ///
    /// If the integer falls within the predefined range (see ``PredefinedBaudRate``) then the baud rate
    /// will be an instance of the `predefined` case. Otherwise it will be an instance of the `custom` case.
    /// - Parameter value: The baud rate of the serial port.
    @inlinable
    public init(integerLiteral value: UInt32) {
        guard let predefined = PredefinedBaudRate(baudRate: value) else {
            self = .custom(value: value)
            return
        }
        self = .predefined(value: predefined)
    }

}
