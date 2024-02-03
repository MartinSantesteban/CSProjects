#ifndef VECTOR_H
#define VECTOR_H
#include<cassert>

#include<iostream>
#include<functional>
#include<vector>

const double TOLERANCE = 1.0e-6;

/**
 * @brief Vector de numeros reales.
 */
class Vector {

public:
    Vector();
    /**
     * @brief constructor del vector nulo.
     * @param[in] size largo del vector.
     */
    Vector(int size);
    /**
     * @param[in] size largo del vector.
     * @param[in] values valores a colocar en el vector.
     */
    Vector(int size, double* values);
    /**
     * @brief constructor por copia.
     * @param[in] V vector a copiar.
     */
    Vector(const Vector& V);
    /**
     * @brief constructor por copia.
     * @param[in] V vector a copiar.
     */
    Vector(const std::vector<double>& V);
    /**
     * @brief constructor por comprension.
     * @param[in] f funcion (i) hacia V[i].
     */
    Vector(int size, std::function<double(int)> f);
    ~Vector();

    Vector& operator =  (const Vector& V);
    Vector& operator =  (const std::vector<double>& V);
    bool    operator == (const Vector& V) const;
    bool    operator != (const Vector& V) const;
    Vector& operator += (const Vector& V);
    Vector  operator +  (const Vector& V) const;
    Vector& operator -= (const Vector& V);
    Vector  operator -  (const Vector& V) const;
    Vector& operator *= (const double& scalar);
    Vector  operator *  (const double& scalar) const;
    Vector  operator -  () const;
    Vector& operator /= (const double& scalar);
    Vector  operator /  (const double& scalar) const;
    friend Vector operator *  (const double& scalar, const Vector V);
    double  operator *  (const Vector& V) const;
    double& operator[](int i) const;

    /**
     * @returns el largo del vector.
     */
    int size() const;
    /**
     * @brief define la tolerancia para la comparacion entre dos matrices.
     */
    void set_tolerance(double tolerance);
    /**
     * @return La tolerancia utilizada para comparaciones.
     */
    double get_tolerance() const;

    /**
     * @param V El vector a concatenar al final.
     * @return El vector concatenado con \p V.
     */
    Vector concatenate (Vector V) const;
    /**
     * @param i El indice de inicio del subvector, inclusivo.
     * @param j El indice de fin del subvector, exclusivo.
     * @return El subvector entre \p i y \p j.
     */
    Vector subvector (int i, int j) const;
    /**
     * @param[in] f funcion a aplicar a todos los elementos del vector.
     */
    void apply(std::function<double(double)> f);

    /**
     * @param[in] size largo del vector.
     * @returns Vector nulo de largo \p n.
     */
    static Vector zero(int size);
    /**
     * @param[in] size largo del vector.
     * @returns Vector con unos de largo \p n.
     */
    static Vector one (int size);
    /**
     * @param[in] V vector a invertir.
     * @returns Vector inverso de \p V.
     */
    static Vector reverse (const Vector& V);
    

    friend std::ostream& operator<< (std::ostream& os, const Vector& V);
    
private:
    int     _size;
    double* _values;
    double  _tolerance;
};

#endif//Vector