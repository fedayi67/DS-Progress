def find_fact(x):
    """Bu fonksiyon Girilen sayinin faktoriyelini dondurur"""
    carpim_degeri = 1
    for i in range(x,0,-1):
        carpim_degeri *= i
    return carpim_degeri

def find_hypo(x,y):
    """Finds the hypothenuse of a right triangle taking 
    inputs of the sides"""
    return (x**2+y**2)**0.5

pi = 3.14 
e = 2.7182