#pragma once
#include<vector>

template<class T>
class Graph {

    public:
        struct Vertex;

        struct Edge {
            Vertex* to;
            double weight;

            Edge(Vertex* to, double weight) : to(to), weight(weight) { }

            bool operator < (const Edge& rhs) {
                return weight < rhs.weight;
            }
        };

        struct Vertex {
            T value;
            std::vector<Edge> neighbours;

            void add_edge(Vertex* rhs, double weight) {
                neighbours.emplace_back(Edge(rhs, weight));
            }
        };
    
        Graph() : vertices(std::vector<Graph<T>::Vertex*>()) { }
        std::vector<Vertex*>& get_vertices() {
            return vertices;
        }
        void add_vertex(const T& value) {
            Vertex* V = new Vertex {value, std::vector<Graph<T>::Edge>()};
            vertices.emplace_back(V);
        }
    
    private:
        std::vector<Vertex*> vertices;
};