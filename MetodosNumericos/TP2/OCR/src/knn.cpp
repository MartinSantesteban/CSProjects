//#include <chrono>
#include "knn.h"
using namespace std;


KNNClassifier::KNNClassifier(unsigned int neighbours) : _neighbours(neighbours) { }

void KNNClassifier::fit(const Eigen::VectorXi& labels, const Matrix& X, PCA pca) {
    _pca = pca;
    if (_pca.components() > 0)
        _samples = _pca.transform(X);
    else
        _samples = X;
    _labels  = labels;
}

Eigen::VectorXi KNNClassifier::predict(const Matrix& X, float pr, Vector recall) {
    Matrix Y;
    if (_pca.components() > 0)
        Y = _pca.transform(X);
    else
        Y = X;
    struct Compare {
        bool operator() (const std::pair<int, double>& A, const std::pair<int, double>& B) {
            return A.second < B.second;
        }
    };
    // Y contiene a las muestras que queremos predecir
    Eigen::VectorXi return_labels(Y.rows());
    for(long int i = 0; i < Y.rows(); ++i) {
        std::priority_queue<std::pair<int, double>, std::vector<std::pair<int, double>>, Compare> q;
        auto x = Y.row(i);
        for(long int j = 0; j < _samples.rows(); ++j) {
            q.push( std::make_pair(_labels(j), (_samples.row(j) - x).norm()) );
            if (q.size() > _neighbours)
                q.pop();
        }
        // en q contengo a los _neighbours ordenados por norma
        std::vector<int> etiquetas(10);
        while(!q.empty()){
            etiquetas[q.top().first]++;
            q.pop();
        }
        //aca saco los votos de las 10 etiquetas
        //auto it = max_element(begin(etiquetas),end(etiquetas));
        for (size_t i = 0; i < 10; ++i)
            etiquetas[i] += (int)(_neighbours * recall(i));

        auto it = max_element(begin(etiquetas), end(etiquetas));
        if(pr*_neighbours <= *it)
            return_labels(i) = it - etiquetas.begin();
        else
            return_labels(i) = -1;
        
    }
    return return_labels;
}
