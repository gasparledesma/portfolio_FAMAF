program p2

 use ISOprec ! definicion de la precision global wp 
 use funciones
 use newt_raph
 
 implicit none

 real( kind = wp )    :: x0 , epsilx , epsily , x , error
 integer              :: Nmax , ni, fu
 character(80)        :: archivo


! ----------------------------------------------------------------------------------------
! caso a ) Menor raíz positiva de la  ecuacion 2x-tan(x) = 0 

 x0 = 1._wp
 epsilx = 1.e-9_wp
 epsily = 1.e-9_wp

 Nmax = 50
 
  write(*,*)' a ) Encontrar la menor solución positva de la  ecuacion 2x-tan(x) = 0 ----- '
  write(*,*) " Datos Iniciales: "
  write(*,*) "  x0 = ", x0 
  write(*,*) " F ( x ) = " , fa(x0)
  write(*,*) " df/dx = " , dfadx(x0)

  
  
  
 archivo = './datos/p2-funcion-a.dat'
 open (newunit = fu, file = archivo )
 

 
 call newton(fa , dfadx , x0 , epsilx , epsily , Nmax , fu , x , error , ni )

 close (fu)
 write (*,*)  " x = " ,x , " error = " , error
 write (*,*)  ' ni = ' ,ni , " fa ( x ) = " , fa ( x )

 

! --------------------------------------------------------------------------
! caso b1 ) Encontrar una aproximación a la raíz de x**2 - 3 = 0 

 x0 = 1._wp
 epsilx = 1.e-9_wp
 epsily = 1.e-9_wp

 Nmax = 50

 write(*,*) ' b1 ) Encontrar una aproximación a la raíz de x**2 - 3 = 0 --------- '

 write(*,*) " Datos Iniciales : "
 write(*,*) " x0 = " , x0
 write(*,*) " F ( x ) = " , fb1(x0)
 write(*,*) " df/dx = ", dfb1dx(x0)
 write(*,*)   
 
 archivo = './datos/p2-funcion-b1.dat '

 open ( newunit = fu, file = archivo )

 call newton(fb1, dfb1dx , x0 , epsilx , epsily , Nmax , fu , x , error , ni )


 close (fu)

 write(*,*) " x = " ,x , "error = " , error
 write(*,*) ' ni = ' ,ni , "fb1(x) = " , fb1(x)



! ------------------- -------------------- ----------------------------------------
! caso b2 )   Encontrar una aproximación a la raíz de x - 3/x = 0 

 x0 = 1._wp
 epsilx = 1.e-9_wp
 epsily = 1.e-9_wp

 Nmax = 50


 write(*,*) ' b2 ) Encontrar una aproximación a la raíz de x - 3/x = 0      ---------- '


 write(*,*) " Datos Iniciales : "
 write(*,*) " x0 = " , x0
 write(*,*) " F(x) = " , fb2(x0)
 write(*,*) " df/dx = " , dfb2dx(x0)





 archivo = './datos/p2-funcion-b2.dat'
 open (newunit = fu , file = archivo )


 call newton ( fb2 , dfb2dx , x0 , epsilx , epsily , Nmax , fu , x , error , ni )


 close (fu)
 write(*,*)  " x = " ,x , "error = " , error
 write(*,*)  ' ni = ' ,ni , "fb2(x) = " , fb2(x)





 write(*,*) " "

 write(*,*) " sqrt(3.0_wp) = " , sqrt(3.0_wp)

 write(*,*) " "



 end program p2



