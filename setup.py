from pathlib import Path
import re
from setuptools import setup, find_packages


TOP_DIR = Path(__file__).parent.resolve()
PACKAGE_NAME = "bad_package"

with open(TOP_DIR.joinpath(f"{PACKAGE_NAME}/__init__.py"), "r") as handle:
    for line in handle.readlines():
        version = re.findall(r'__version__ = "(.*)"', line)
        if version:
            break
    else:
        raise RuntimeError(f"Could not determine version from {PACKAGE_NAME}/__init__.py")

with open(TOP_DIR.joinpath("requirements.txt")) as handle:
    REQUIREMENTS = handle.read()

setup(
    name=PACKAGE_NAME,
    version=version[0],
    description="This example package will fail to install a built source distribution.",
    packages=find_packages(),
    install_requires=REQUIREMENTS,
)
