#include <rclcpp/rclcpp.hpp>
#include <exception>

using namespace geometry_msgs::msg;
using namespace std::chrono_literals;

class Control : public rclcpp::Node
{
public:
  Control() : Node("node_name")
  {
    set_parameter(rclcpp::Parameter("parameter", true));

    RCLCPP_INFO(this->get_logger(), "Node has been started.");
  }

private:

};



int main(int argc, char** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<Control>());
  rclcpp::shutdown();
  return 0;
}