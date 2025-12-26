# Simple ROS2 package template
[![License](https://img.shields.io/badge/License-GNU--3..0-blue)](#license)

This is a simple template for creating a ROS2 package. It includes the basic structure and files needed to get started with a ROS2 project.

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/pisteuralpin/simple_ros2_package_template.git
   ```
2. Navigate to the package directory:
   ```bash
   cd simple_ros2_package_template
   ```
3. Make `configure.sh` executable:
   ```bash
   chmod +x configure.sh
   ```
4. Run the configuration script:
   ```bash
   ./configure.sh
   ```
5. Follow the prompts to set up your package name and other configurations.

## Package Structure
```
simple_ros2_package/
├── CMakeLists.txt
├── package.xml
├── setup.py
├── src/
├── launch/
│   └── example.launch.py
└── README.md
```