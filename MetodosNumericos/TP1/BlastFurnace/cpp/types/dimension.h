/**
 * @brief Tupla describiendo las dimensiones de una matriz.
 */
struct Dimension{
    int m;
    int n;

    /**
     * @brief Construye una dimensión nula (0, 0).
     */
    Dimension() : m(0), n(0) { }
    /**
     * @brief Construye una dimensión nula (m, n).
     */
    Dimension(int m, int n) : m(m), n(n) { }

    inline bool operator == (const Dimension D) const {
        return (m == D.m) && (n == D.n);
    }

    inline bool operator != (const Dimension D) const {
        return (m != D.m) || (n != D.n);
    }
};