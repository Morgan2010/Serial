/**
 * posix.c
 * Serial
 * 
 * Created by Morgan McColl.
 * Copyright © 2025 Morgan McColl. All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials
 *    provided with the distribution.
 * 
 * 3. All advertising materials mentioning features or use of this
 *    software must display the following acknowledgement:
 * 
 *    This product includes software developed by Morgan McColl.
 * 
 * 4. Neither the name of the author nor the names of contributors
 *    may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * -----------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or
 * modify it under the above terms or under the terms of the GNU
 * General Public License as published by the Free Software Foundation;
 * either version 2 of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/licenses/
 * or write to the Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA  02110-1301, USA.
 */

#if !(defined(__WIN32) || defined(WIN32))

#include "include/CSerial/types.h"
#include "include/CSerial/CSerial.h"
#include "include/CSerial/file_mode.h"
#include "stdio.h"
#include <fcntl.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>
#include <stdint.h>
#include <limits.h>
#include <errno.h>
#include <string.h>
#include "include/CSerial/cserial_posix.h"

// Opens the specified serial port, configures its timeouts, and sets its
// baud rate.  Returns a handle on success, or INVALID_HANDLE_VALUE on failure.
HANDLE_TYPE open_serial_port(const char * device, CSERIAL_CONFIGURATION_TYPE configuration) {
    HANDLE_TYPE fd = open(device, CSERIAL_posix_mode(configuration.mode));
    if (fd < 0)
        CSERIAL_exit(EXIT_FAILURE);
    CSERIAL_initialise(fd, configuration);
    return fd;
}

SIZE_TYPE write_port(HANDLE_TYPE port, uint8_t *data, size_t size) {
    return (SIZE_TYPE)(write(port, data, size));
}

SIZE_TYPE read_port(HANDLE_TYPE port, uint8_t * buffer, size_t size) {
    return (SIZE_TYPE)(read(port, buffer, size));
}

int CSERIAL_posix_mode(CSERIAL_FILEMODE_TYPE mode) {
    switch (mode)
    {
        case CSERIAL_READ: return O_RDONLY;
        case CSERIAL_WRITE: return O_WRONLY;
        case CSERIAL_READ_WRITE: return O_RDWR;
        default: return -1;
    }
}

int CSERIAL_baud_rate(CSERIAL_BAUDRATE_TYPE rate) {
    if (rate.is_predefined)
    {
        const uint32_t predefined = rate.baud_rate.predefined;
        if ((uint32_t)(INT_MAX) < predefined || predefined <= 0)
            CSERIAL_exit(EXIT_FAILURE);
        return (int)(predefined);
    }
    switch (rate.baud_rate.baud_rate) {
        case CSERIAL_110: return B110;
        case CSERIAL_300: return B300;
        case CSERIAL_600: return B600;
        case CSERIAL_1200: return B1200;
        case CSERIAL_2400: return B2400;
        case CSERIAL_4800: return B4800;
        case CSERIAL_9600: return B9600;
        case CSERIAL_14400: return 14400;
        case CSERIAL_19200: return B19200;
        case CSERIAL_38400: return B38400;
        case CSERIAL_57600: return B57600;
        case CSERIAL_115200: return B115200;
        case CSERIAL_128000: return 128000;
        case CSERIAL_256000: return 256000;
        default: return -1;
    }
}

void CSERIAL_exit(int code)
{
    printf("Error: %s\n", strerror(errno));
    exit(code);
}

tcflag_t CSERIAL_data_bits(uint32_t bits) {
    switch (bits)
    {
        case 5: return CS5;
        case 6: return CS6;
        case 7: return CS7;
        case 8: return CS8;
        default: return (tcflag_t)(bits);
    }
}

tcflag_t CSERIAL_stop_bits(uint32_t stop_bits)
{
    switch (stop_bits)
    {
        case 2: return CSTOPB;
        default: return 0;
    }
}

tcflag_t CSERIAL_hardware_flow_control_cflag(CSERIAL_HARDWARE_FLOW_CONTROL_TYPE use_hardware_flow_control) {
    switch (use_hardware_flow_control)
    {
        case CSERIAL_RTS_CTS_CD: return CREAD | ~CLOCAL;
        default: return CREAD | CLOCAL;
    }
}

void CSERIAL_initialise(HANDLE_TYPE fd, CSERIAL_CONFIGURATION_TYPE configuration)
{
    struct termios tty;
    if (tcgetattr(fd, &tty) != 0)
        CSERIAL_exit(EXIT_FAILURE);
    const int baud_rate = CSERIAL_baud_rate(configuration.baud_rate);
    if (baud_rate == -1)
        CSERIAL_exit(EXIT_FAILURE);
    cfsetospeed(&tty, baud_rate);
    cfsetispeed(&tty, baud_rate);
    if (configuration.data_bits < 5 || configuration.data_bits > 8)
        exit(EXIT_FAILURE);
    
    // Set data bits.
    tty.c_cflag &= ~CSIZE;
    tty.c_cflag |= CSERIAL_data_bits(configuration.data_bits);
    // Set stop bits.
    tty.c_cflag &= ~CSTOPB;
    if (configuration.stop_bits != 1 || configuration.stop_bits != 2)
        exit(EXIT_FAILURE);
    const tcflag_t stop_bits = CSERIAL_stop_bits(configuration.stop_bits);
    tty.c_cflag |= stop_bits;
    // Set parity bits.
    tty.c_cflag &= ~PARENB;
    tty.c_cflag |= CSERIAL_parity(configuration.parity);
    // Set hardware flow control (RTS/CTS and CD lines).
    tty.c_cflag |= CSERIAL_hardware_flow_control_cflag(configuration.hardware_flow_control);
    // Disable canonical mode (i.e. never wait for newlines).
    tty.c_lflag &= ~ICANON;
    tty.c_lflag &= ~ECHO;
    tty.c_lflag &= ~ECHOE;
    tty.c_lflag &= ~ECHONL;
    tty.c_lflag &= ~ISIG;
    // Set software flow control.
    if (configuration.use_software_flow_control)
    {
        tty.c_iflag |= (IXON | IXOFF | IXANY);
    } else
    {
        tty.c_iflag &= ~(IXON | IXOFF | IXANY);
    }
    // Turn off output byte processing (don't convert chars e.g. CRLF to LF).
    tty.c_oflag &= ~OPOST;
    tty.c_oflag &= ~ONLCR;
    // Set timeouts to 0 - polling approach.
    tty.c_cc[VTIME] = 0;
    tty.c_cc[VMIN] = 0;
    if (tcsetattr(fd, TCSANOW, &tty) != 0)
        CSERIAL_exit(errno);
}

int CSERIAL_parity(CSERIAL_PARITY_TYPE parity) {
    switch (parity)
    {
        case CSERIAL_NO_PARITY: return ~(PARENB | PARODD);
        case CSERIAL_ODD_PARITY: return PARENB | PARODD;
        case CSERIAL_EVEN_PARITY: return PARENB;
        default: return -1;
    }
}

#endif
