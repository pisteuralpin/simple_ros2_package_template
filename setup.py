from setuptools import setup, find_packages
from glob import glob
import os

package_name = '<?package_name?>'

setup(
    name='<?package_name?>',
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        (os.path.join('share', package_name), ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.py')),
        (os.path.join('share', package_name, 'resource'), glob('resource/*')),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='<?author_name?>',
    maintainer_email='<?author_email?>',
    description='<?package_description?>',
    license='<?package_license?>',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            # 'node_name = ros2_package_template.node_module:main',
        ],
    },
)