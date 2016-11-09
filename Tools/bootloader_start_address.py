import argparse
import sys


# This should eventually be moved to a configuration file
MCU_INFO = {
    'atmega328p': {
        'flash_size': 32 * 1024,
        'boot_sizes': [512, 1024, 2048, 4096]
    }
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--mcu', required=True)
    parser.add_argument('--bootsize', required=True)
    args = parser.parse_args()

    try:
        mcu = MCU_INFO[args.mcu]
    except KeyError:
        sys.exit('Unsupported MCU: {}'.format(args.mcu))

    try:
        bootsize = int(args.bootsize)
    except ValueError:
        sys.exit('Illegal bootsize format: {}'.format(args.bootsize))

    if bootsize not in mcu['boot_sizes']:
        error = 'MCU {} does not support boot size {} (supported sizes are {})'
        sys.exit(error.format(args.mcu, bootsize,
                              ', '.join(str(s) for s in mcu['boot_sizes'])))

    start_address = mcu['flash_size'] - bootsize
    print(hex(start_address), end='')


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        sys.exit(e)
