// file_mode.h
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

#ifndef CSERIAL_FILEMODE_H
#define CSERIAL_FILEMODE_H
#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef enum CSERIAL_FileMode {
    CSERIAL_READ = 0,
    CSERIAL_WRITE = 1,
    CSERIAL_READ_WRITE = 2
} CSERIAL_FILEMODE_TYPE;

typedef enum CSERIAL_Parity {
    CSERIAL_NO_PARITY = 0,
    CSERIAL_ODD_PARITY = 1,
    CSERIAL_EVEN_PARITY = 2
} CSERIAL_PARITY_TYPE;

typedef enum CSERIAL_PreDefinedBaudRate {
    CSERIAL_110 = 0,
    CSERIAL_300 = 1,
    CSERIAL_600 = 2,
    CSERIAL_1200 = 3,
    CSERIAL_2400 = 4,
    CSERIAL_4800 = 5,
    CSERIAL_9600 = 6,
    CSERIAL_14400 = 7,
    CSERIAL_19200 = 8,
    CSERIAL_38400 = 9,
    CSERIAL_57600 = 10,
    CSERIAL_115200 = 11,
    CSERIAL_128000 = 12,
    CSERIAL_256000 = 13
} CSERIAL_PREDEFINED_BAUDRATE_TYPE;

union CSERIAL_BaudRate_Union {
    uint32_t baud_rate;
    CSERIAL_PREDEFINED_BAUDRATE_TYPE predefined;
};

typedef struct CSERIAL_BaudRate {
    union CSERIAL_BaudRate_Union baud_rate;
    bool is_predefined;
} CSERIAL_BAUDRATE_TYPE;

typedef enum CSERIAL_HardwareFlowControl {
    CSERIAL_None = 0,
    CSERIAL_RTS_CTS = 1,
    CSERIAL_RTS_CTS_CD = 2
} CSERIAL_HARDWARE_FLOW_CONTROL_TYPE;

typedef struct CSERIAL_Configuration {
    CSERIAL_FILEMODE_TYPE mode;
    CSERIAL_PARITY_TYPE parity;
    CSERIAL_BAUDRATE_TYPE baud_rate;
    uint32_t data_bits;
    uint32_t stop_bits;
    CSERIAL_HARDWARE_FLOW_CONTROL_TYPE hardware_flow_control;
    bool use_software_flow_control;
} CSERIAL_CONFIGURATION_TYPE;

#ifdef __cplusplus
}
#endif
#endif
