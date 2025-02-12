// CSerial.h
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

#ifndef CSERIAL_H
#ifdef __cplusplus
extern "C" {
#endif

#define CSERIAL_H

#include "stdbool.h"
#include "stdint.h"
#include "types.h"
#include "file_mode.h"

/// Opens the specified serial port, configures its timeouts, and sets its
/// baud rate.  Returns a handle on success, or INVALID_HANDLE_VALUE on failure.
/// - device: The name of the serial port to open.
/// - configuration: The configuration to use for the serial port.
HANDLE_TYPE CSERIAL_open_serial_port(const char *, CSERIAL_CONFIGURATION_TYPE);

/// Writes bytes to the serial port, returning number of bytes written on success and -1 on failure.
SIZE_TYPE CSERIAL_write_port(HANDLE_TYPE port, uint8_t *, SIZE_TYPE);

/// Reads bytes from the serial port.
/// Returns after all the desired bytes have been read, or if there is a
/// timeout or other error.
/// Returns the number of bytes successfully read into the buffer, or -1 if
/// there was an error reading.
SIZE_TYPE CSERIAL_read_port(HANDLE_TYPE port, uint8_t * buffer, SIZE_TYPE size);

/// Closes the specified handle to the serial port.
void CSERIAL_close_port(HANDLE_TYPE port);

#if defined(__WIN32) || defined(WIN32)

#else
#include "cserial_posix.h"
#endif

#ifdef __cplusplus
}
#endif
#endif // CSERIAL_H

