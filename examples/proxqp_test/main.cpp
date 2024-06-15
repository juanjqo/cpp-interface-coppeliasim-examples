
#pragma once

#include <memory>
#include <dqrobotics/solvers/DQ_PROXQPSolver.h>

using namespace Eigen;
using namespace DQ_robotics;

int main(){
    auto proxqp_solver = std::make_shared<DQ_PROXQPSolver>();

    MatrixXd H = MatrixXd::Zero(3,3);
    H << 1,-1, 1,
        -1, 2,-2,
        1,-2, 4;

    VectorXd f = VectorXd::Zero(3);
    f << 2,-3, 1;

    VectorXd lb = VectorXd::Zero(3);
    VectorXd ub = VectorXd::Ones(3);

    MatrixXd Aeq = MatrixXd::Ones(1,3);
    VectorXd beq = VectorXd::Ones(1);
    beq(0) = 0.5;

    MatrixXd A(6,3);
    VectorXd b(6);
    MatrixXd I = MatrixXd::Identity(3,3);
    A << I, -I;
    b << ub, -lb;

    auto u = proxqp_solver->solve_quadratic_program(H, f, A, b, Aeq, beq);
    std::cout<<"u: "<<u.transpose()<<std::endl;
}
