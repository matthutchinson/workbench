from random import choices
from string import ascii_lowercase, digits
from os import listdir, remove
from os.path import isfile, join
from typing import List
from PIL import Image
from pillow_heif import HeifImagePlugin


RANDOM_STRING_LENGTH = 4
DEFAULT_CONVERT_FROM_EXT = ".heic"
DEFAULT_CONVERT_TO_EXT = ".png"
SUFFIX_SEPERATOR = "_"


def generate_random_string(length=RANDOM_STRING_LENGTH):
    return ''.join(choices(ascii_lowercase + digits, k=length))


# if dest is not a file then it is valid so returns True
def validate_dest(dest):
    return not isfile(dest)


# predicts the length of the list ls would return
def ls_size(_dir, recurse=False, extension_filter=DEFAULT_CONVERT_FROM_EXT):
    size = 0

    _files = [join(_dir, f) for f in listdir(_dir)]
    for f in _files:
        if isfile(f):
            if f.lower().endswith(extension_filter):
                size += 1
        else:
            if recurse:
                size += ls_size(join(_dir, f), recurse)

    return size


# returns all files with names ending with extension_filter
# can do both top level and recursive
def ls(_dir, recurse=False, extension_filter=DEFAULT_CONVERT_FROM_EXT) -> List[str]:
    files = []

    _files = [join(_dir, f) for f in listdir(_dir)]
    for f in _files:
        if isfile(f):
            files.append(f)
        else:
            if recurse:
                files += ls(join(_dir, f), recurse)

    return [f for f in files if f.lower().endswith(extension_filter)]


def build_dest_path(src, suffix="", from_ext=DEFAULT_CONVERT_FROM_EXT, to_ext=DEFAULT_CONVERT_TO_EXT):

    # at first suffix is empty string so file name is
    # same just different extension
    dest = f"{src[:-len(from_ext)]}{suffix}{to_ext}"

    if validate_dest(dest):
        return dest
    else:
        # if using a random suffix prepend it with a seperator
        if suffix == "":
            suffix += SUFFIX_SEPERATOR

        # will keep making suffix longer until file name is accepted
        suffix += generate_random_string()
        return build_dest_path(src, suffix, from_ext, to_ext)


# receives validated dest
def convert(src, dest):
    i = Image.open(src)
    i.save(dest)


def process_dir(_dir, recurse=False, delete_original=False):
    files = ls(_dir, recurse)

    for f in files:
        convert(f, build_dest_path(f))
        if delete_original:
            remove(f)
