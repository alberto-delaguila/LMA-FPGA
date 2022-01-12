from random import *
import math

NPOINTS = 250
EPSILON = 0.01
NOISE = 10
MININPUT = 0
MAXINPUT = 2500

class PolinomialHessian:
    def __init__(self, order, learn_factor = 1):
        self.order = order
        self.size = order+1
        self.l = learn_factor
        self.matrix = [[0 for _ in range(self.size)]+[0] for _ in range(self.size)]
    
    def print(self):
        for row in self.matrix:
            for item in row:
                print(item, end=" ")
            print()
        print()

    def add(self, x):
        for r in range(self.size):
            for c in range(self.size):
                self.matrix[r][c] += x**(2*self.order - (r+c))

    def set_b(self, b):
        i = 0
        for row in self.matrix:
            row[-1] = b[i]
            i += 1

    def solve(self):
        
        m = [[self.matrix[r][c] for c in range(self.size+1)] for r in range(self.size)]

        for pivot in range(self.size):
            f_p = m[pivot][pivot]
            for c in range(self.size+1):
                m[pivot][c] = m[pivot][c]/f_p

            for r in range(self.size):
                if r != pivot:
                    f_mult = m[r][pivot]
                    for c in range(self.size+1):
                        m[r][c] -= f_mult*m[pivot][c]

        return [row[-1] for row in m]


if __name__ == '__main__':

    X = [uniform(MININPUT,MAXINPUT) for _ in range(NPOINTS)]

    A = 58.12
    B = -15.61
    C = 1.2101
    D = -0.023
    E = -89.01
    
    Yr = [A*x**4 + B*x**3 + C*x**2 + D*x**1 + E*x**0 + uniform(-NOISE,NOISE) for x in X]


    h = PolinomialHessian(4)

    a = uniform(-1,1)
    b = uniform(-1,1)
    c = uniform(-1,1)
    d = uniform(-1,1)
    e = uniform(-1,1)

    run = True

    while run:
    
        Ye = [a*x**4 + b*x**3 + c*x**2 + d*x**1 + e*x**0 for x in X]
        
        diff_list = [yr - ye for yr, ye in zip(Yr, Ye)]

        p = [0, 0, 0, 0, 0]

        for dif, x in zip(diff_list, X):
            p[0] += dif*x**4
            p[1] += dif*x**3
            p[2] += dif*x**2
            p[3] += dif*x**1
            p[4] += dif*x**0

        for data in X:
            h.add(data)

        h.set_b(p)
        
        delta = h.solve()
        a += delta[0]
        b += delta[1]
        c += delta[2]
        d += delta[3]
        e += delta[4]

        r = 0
        for delt in delta:
            r += delt**2
        r = math.sqrt(r)

        print("a:",a,"b:",b,"c:",c,"d:",d,"e:",e, "  r:",r)
        run = r > EPSILON