#include <iostream>
#include <dqrobotics/DQ.h>
#include <dqrobotics/interfaces/coppeliasim/DQ_CoppeliaSimInterface.h>


using namespace DQ_robotics;
using namespace Eigen;

int main()
{
    auto vi = std::make_shared<DQ_CoppeliaSimInterface>();
    vi->connect();
    vi->set_gravity(DQ(0));
    vi->set_stepping_mode(true);

    std::string robotname = "/Sphere";


    vi->start_simulation();

    for (int i=0; i<200; i++)
    {
        DQ x = vi->get_object_pose(robotname);

        DQ w = 0.1*k_;
        DQ p_dot = 0.1*j_;

        //vi->set_angular_and_linear_velocities(robotname, w, p_dot);

        DQ twist_b = w + E_*(p_dot);
        DQ twist_a = x*twist_b*x.conj();

        vi->set_twist(robotname, twist_b,
                      DQ_CoppeliaSimInterface::BODY_FRAME);

        std::cout<<"twist_a :    "<<twist_a<<std::endl;
        std::cout<<"twist_a_:    "<<vi->get_twist(robotname)<<std::endl;
        std::cout<<" "<<std::endl;
        std::cout<<"twist_b :    "<<twist_b<<std::endl;
        std::cout<<"twist_b_:    "<<vi->get_twist(robotname, DQ_CoppeliaSimInterface::BODY_FRAME)<<std::endl;


        vi->trigger_next_simulation_step();
    }

    vi->stop_simulation();
}
