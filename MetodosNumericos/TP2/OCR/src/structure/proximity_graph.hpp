#pragma once
#include "../types.h"
#include "../eigen.h"
#include "graph.hpp"

class ProximityGraph {
    typedef std::pair<Vector, uint> Data;
    enum NeighbourMethod {Trivial, Relative, Gabriel};

    public:
        ProximityGraph(const Matrix& vertices, const Eigen::VectorXi& labels, NeighbourMethod = Trivial) {
            for(long int i = 0; i < vertices.rows(); ++i)
                G.add_vertex(Data{vertices.row(i), labels[i]});

            for (Graph<Data>::Vertex* u : G.get_vertices())
            for (Graph<Data>::Vertex* v : G.get_vertices())
                switch (neighbour_method) {
                    case Trivial:
                        return;
                    case Relative: {
                        double radius = (u->value.first - v->value.first).norm();
                        for (Graph<Data>::Vertex* w : G.get_vertices())
                            if ((u != v && u != w && v != w) && (u->value.first - w->value.first).norm() <= radius && (v->value.first - w->value.first).norm() <= radius)
                                break;
                        u->add_edge(v, radius);
                        v->add_edge(u, radius);
                        break;
                    }
                    case Gabriel: {
                        double radius = (u->value.first - v->value.first).norm() / 2.0;
                        Vector center = (u->value.first + v->value.first) / 2.0;
                        for (Graph<Data>::Vertex* w : G.get_vertices())
                            if ((u != v && u != w && v != w) && (center - w->value.first).norm() <= radius)
                                break;
                        u->add_edge(v, radius * 2.0);
                        v->add_edge(u, radius * 2.0);
                        break;
                    }
                }
        };

    private:
        Graph<Data> G;
        NeighbourMethod neighbour_method;
};