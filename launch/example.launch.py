from simple_launch import SimpleLauncher
from ament_index_python.packages import get_package_share_directory
import os

sl = SimpleLauncher(use_sim_time=True)
sl.declare_arg('arg', 'arg_value')
pkg_share_directory = get_package_share_directory('<?package_name?>')


def launch_setup():
    
    

    return sl.launch_description()


generate_launch_description = sl.launch_description(launch_setup)