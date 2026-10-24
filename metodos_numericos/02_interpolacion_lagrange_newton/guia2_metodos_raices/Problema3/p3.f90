program p3
 
    use ISOprec ! definicion de la precision global wp 
    use funcionesb
    use funcionesn
    use newt_raph
    use biseccion
    
    implicit none
   
    !metodo de biseccion

    real( kind = wp )    :: x0 , epsilx , epsily , x , error
    integer              :: Nmax , ni, fu, m
    character(80)        :: archivo
    real (kind=wp)       :: a, b

    a = 0.0_wp
    b = 2.5_wp
  
    epsilx = 1.e-10_wp
    epsily = 1.e-10_wp
  
    !m = 10 ! para probar
     m = 50
  
    write(*,*) ' Biseccion'
  
    write(*,*) ' funcion '
    write(*,*) " a =",a, "b =",b
    write(*,*) " epsilx =",epsilx , " epsily =",epsily , " m =",m
  
    archivo = 'datos/bisection_errors.dat'
    open(newunit = fu, file = archivo )
  
    call bisec (h , a, b, epsilx , epsily ,fu ,x, error , m, ni)
  
    write(*,*) " x =",x," error =",error
    write(*,*) 'ni =',ni ," h (x) =",h (x)
    write(*,*) " "
    
    close(fu)
    
    write(*,*) " sqrt(3.0_wp) =", sqrt(3.0_wp )
    write(*,*) " "
  

    write(*,*)""
  
  
    ! metodo de newton
    write(*,*)"newton"
    x0 = 2.5_wp
    epsilx = 1.e-10_wp
    epsily = 1.e-10_wp
    
    Nmax = 50
   
    write(*,*) ' Encontrar una aproximación a la raíz de x**2 - 3 = 0 --------- '
   
    write(*,*) " Datos Iniciales : "
    write(*,*) " x0 = " , x0
    write(*,*) " F ( x ) = " , g(x0)
    write(*,*) " dg/dx = ", dgdx(x0)
    write(*,*)   
    
    archivo = './datos/newton_errors.dat '
   
    open ( newunit = fu, file = archivo )
   
    call newton(g, dgdx , x0 , epsilx , epsily , Nmax , fu , x , error , ni )
   
   
    close (fu)
   
    write(*,*) " x = " ,x , "error = " , error
    write(*,*) ' ni = ' ,ni , "g(x) = " , g(x) 

   

    
end program p3