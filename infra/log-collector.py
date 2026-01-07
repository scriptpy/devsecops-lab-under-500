#!/usr/bin/env python3
"""
Log Collector Agent - Week 4
Collects system logs and metrics from lab devices

Copyright (C) 2026  G A Istrati

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

This project is for educational purposes only. Users are responsible for
ensuring their use complies with all applicable laws.
"""

import platform
import os
from datetime import datetime
from dotenv import load_dotenv
from pathlib import Path


# Load .env file
env_path = Path(__file__).parent.parent / 'security' / 'secrets' / '.env'
load_dotenv(env_path)

# Read a value from .env
test_message = os.getenv('TEST_MESSAGE')


def get_system_info():
    """Collect basic system information"""
    info = {
        'hostname': platform.node(),
        'platform': platform.system(),
        'platform_release': platform.release(),
        'architecture': platform.machine(),
        'processor': platform.processor(),
        'timestamp': datetime.now().isoformat()
    }
    return info

def get_memory_info():
    """Get memory information (works on both Windows and Linux)"""
    try:
        import psutil
        mem = psutil.virtual_memory()
        return {
            'total_memory_gb': round(mem.total / (1024**3), 2),
            'available_memory_gb': round(mem.available / (1024**3), 2),
            'used_memory_gb': round(mem.used / (1024**3), 2),
            'memory_percent': mem.percent
        }
    except ImportError:
        # psutil not installed, return basic info
        return {'note': 'Install psutil for detailed memory info: pip install psutil'}

def main():
    """Main function - collects and displays system information"""
    
    print("=== Log Collector Starting ===")
    
    # Test .env file loading
    if test_message:
        print(f"\n--- .env Test ---")
        print(f"Message from .env: {test_message}")
    
    # Get system info
    system_info = get_system_info()
    print(f"\n--- System Information ---")
    print(f"Hostname: {system_info['hostname']}")
    print(f"Platform: {system_info['platform']} {system_info['platform_release']}")
    print(f"Architecture: {system_info['architecture']}")
    print(f"Processor: {system_info['processor']}")
    print(f"Timestamp: {system_info['timestamp']}")
    
    # Get memory info
    memory_info = get_memory_info()
    print(f"\n--- Memory Information ---")
    if 'note' in memory_info:
        print(memory_info['note'])
    else:
        print(f"Total Memory: {memory_info['total_memory_gb']} GB")
        print(f"Available: {memory_info['available_memory_gb']} GB")
        print(f"Used: {memory_info['used_memory_gb']} GB ({memory_info['memory_percent']}%)")
    
    print("\n=== Collection Complete ===")

if __name__ == '__main__':
    main()

