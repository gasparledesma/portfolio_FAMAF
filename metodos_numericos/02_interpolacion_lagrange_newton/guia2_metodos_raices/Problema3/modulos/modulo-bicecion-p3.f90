module biseccion

    use ISOprec   ! definición de la precisión global wp
    
    use funcionesb
   
    contains
   
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   
    subroutine bisec (h ,a ,b ,epsix ,epsiy , unidad ,x ,error ,eme , niter )
    
    ! ********************************************************************
    ! metodo de biseccion
    !
    !
    ! f = funcion definida en modulo
    ! a = entrada , punto inferior del rango
    ! b = entrada , punto superior del rango
    ! epsix = error de tolarancia en x
    ! epsiy = error de tolerancia en f
    ! x = valor de la raíz
    ! eme = numero de iteraciones elegido
    ! niter = numero de iteraciones realizadas
    !
    ! ********************************************************************
    
    implicit none
    integer , intent(in) :: eme
    integer , intent(out) :: niter
    integer :: nmax , n, unidad
    real (kind=wp) :: a, b, h, ha , hb , hx , epsix , epsiy
    real (kind=wp), intent (out) ::x, error
   
    nmax = int((log (b-a)-log(epsix))/ log(2._wp )) + 1
   
   
    if (eme > nmax ) then
    
    write (* ,*)  " ************************************************ "
    write (*,*)   "* Dado el intervalo, la precisión en x se puede "
    write (*,*)   "* alcanzar con nmax =",nmax
    write (*,*)   " ************************************************ "
    endif
   
    ha = h(a)
   
    hb = h(b)
    if ( sign (1.0_wp ,ha) == sign (1.0_wp ,hb) ) then
          print *,"La funcion tiene el mismo signo en",a,b
     
    else
          write (unidad ,*)"# n            x                 error    " ,&
                      "         rel error              f(x)   " 
                      
          error = (b - a) *0.5_wp
          x = a + error
          hx = h(x)
          
           do n = 1, eme
          
               if ( sign (1.0_wp ,ha) /= sign (1.0_wp ,hx) ) then
                   b = x
                   hb = hx
                   
               else
               
                   a = x
                   ha = hx
                
               endif
               
               error = (b - a) *0.5_wp
               x = a + error
               hx = h(x)
               
               
               write (unidad ,'(I4 ,4(x,E19.12) )') n, x, error, ((b-a)/(a+b)), hx 
                niter = n + 1 !una iteración fuera del 'do '
                
               if (n==eme) then
            
               write (*,*) " ************************************************ "
               write (*,*) "* Se alcanzó el número pedido de iteraciones .*"
               write (*,*) "* Debe incrementarlo para garantizar la *"
               write(*,*)  "* precisión requerida. *"
               write(*,*)  " ************************************************ "
               
               endif
            
               if (( error < epsix ).and.(abs(hx) < epsiy )) exit
            
            end do
           
           
    end if
   
    end subroutine bisec
   
    end module biseccion
   