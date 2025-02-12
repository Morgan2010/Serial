// PredefinedBaudRate.swift
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

/// A predefined baud rate for a serial port.
public enum PredefinedBaudRate: CTypeConvertible {

    /// 110 baud.
    case baud110

    /// 300 baud.
    case baud300

    /// 600 baud.
    case baud600

    /// 1200 baud.
    case baud1200

    /// 2400 baud.
    case baud2400

    /// 4800 baud.
    case baud4800

    /// 9600 baud.
    case baud9600

    /// 14400 baud.
    case baud14400

    /// 19200 baud.
    case baud19200

    /// 38400 baud.
    case baud38400

    /// 57600 baud.
    case baud57600

    /// 115200 baud.
    case baud115200

    /// 128000 baud.
    case baud128000

    /// 256000 baud.
    case baud256000

    /// The equivalent C type for this baud rate.
    @inlinable public var ctype: CSERIAL_PREDEFINED_BAUDRATE_TYPE {
        switch self {
        case .baud110:
            return CSERIAL_110
        case .baud300:
            return CSERIAL_300
        case .baud600:
            return CSERIAL_600
        case .baud1200:
            return CSERIAL_1200
        case .baud2400:
            return CSERIAL_2400
        case .baud4800:
            return CSERIAL_4800
        case .baud9600:
            return CSERIAL_9600
        case .baud14400:
            return CSERIAL_14400
        case .baud19200:
            return CSERIAL_19200
        case .baud38400:
            return CSERIAL_38400
        case .baud57600:
            return CSERIAL_57600
        case .baud115200:
            return CSERIAL_115200
        case .baud128000:
            return CSERIAL_128000
        case .baud256000:
            return CSERIAL_256000
        }
    }

    /// Initialise the PredefinedBaudRate from it's corresponding C Type.
    /// - Parameter ctype: The C type to initialise from.
    @inlinable
    public init(ctype: CSERIAL_PREDEFINED_BAUDRATE_TYPE) {
        switch ctype {
        case CSERIAL_110:
            self = .baud110
        case CSERIAL_300:
            self = .baud300
        case CSERIAL_600:
            self = .baud600
        case CSERIAL_1200:
            self = .baud1200
        case CSERIAL_2400:
            self = .baud2400
        case CSERIAL_4800:
            self = .baud4800
        case CSERIAL_9600:
            self = .baud9600
        case CSERIAL_14400:
            self = .baud14400
        case CSERIAL_19200:
            self = .baud19200
        case CSERIAL_38400:
            self = .baud38400
        case CSERIAL_57600:
            self = .baud57600
        case CSERIAL_115200:
            self = .baud115200
        case CSERIAL_128000:
            self = .baud128000
        case CSERIAL_256000:
            self = .baud256000
        default:
            fatalError("Unknown baud rate: \(ctype)")
        }
    }

}
