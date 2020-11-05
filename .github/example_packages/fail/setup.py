from pathlib import Path
import re
from setuptools import setup, find_packages


TOP_DIR = Path(__file__).parent.resolve()

with open(TOP_DIR.joinpath("failing_package/__init__.py"), "r") as handle:
    for line in handle.readlines():
        version = re.findall(r'__version__ = "(.*)"', line)
        if version:
            break
    else:
        raise RuntimeError("Could not determine version from failing_package/__init__.py")

with open(TOP_DIR.joinpath("requirements.txt")) as handle:
    REQUIREMENTS = handle.read()

setup(
    name="failing_package",
    version=version[0],
    description="This example package will fail to build a source distribution.",
    packages=find_packages(),
    install_requires=REQUIREMENTS,
)
