import argparse
import sys

from elftools.elf.elffile import ELFFile


def elf_type(file_name):
    return ELFFile(open(file_name, 'rb'))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--elf-file', type=elf_type)
    parser.add_argument('--size', type=int)
    args = parser.parse_args()

    text_section = args.elf_file.get_section_by_name('.text')
    text_size = text_section.header['sh_size']

    if text_size > args.size:
        sys.exit('Bootloader too large: {} > {}'.format(text_size, args.size))
