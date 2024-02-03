#include <pybind11/pybind11.h>
#include <pybind11/eigen.h>
#include "knn.h"
#include "pca.h"
#include "eigen.h"

namespace py=pybind11;

// el primer argumento es el nombre...
PYBIND11_MODULE(metnum, m) {
    py::enum_<StopCriterion>(m, "StopCriterion")
        .value("iteration"   , StopCriterion::Iteration)
        .value("vector_delta", StopCriterion::VectorDelta)
        .value("eigen_value" , StopCriterion::IsEigenValue);
    py::class_<KNNClassifier>(m, "KNNClassifier")
        .def(py::init<unsigned int>())
        .def("fit", &KNNClassifier::fit)
        .def("predict", &KNNClassifier::predict);
    py::class_<PCA>(m, "PCA")
        .def(py::init<unsigned int>())
        .def("fit", &PCA::fit);
    m.def(
        "power_iteration", &power_iteration,
        "Function that calculates eigenvector",
        py::arg("X"),
        py::arg("criterion"),
        py::arg("num_iter")=5000,
        py::arg("epsilon")=1e-10
    );
    m.def(
        "get_first_eigenvalues", &get_first_eigenvalues,
        "Function that calculates eigenvector",
        py::arg("X"),
        py::arg("num"),
        py::arg("criterion"),
        py::arg("num_iter")=5000,
        py::arg("epsilon")=1e-10
    );

}
