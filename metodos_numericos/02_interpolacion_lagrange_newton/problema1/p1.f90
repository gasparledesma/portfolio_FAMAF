program p1

    use ISOprec
    USE funciones

    implicit none
    integer             ::n,i,R, k
    real(kind=wp)       ::Lk, L, C


   
    Lk=1._wp
    do i = 0 , R
    
        if (i/=k) L = L*(C-x(i))/(x(k)-x(i))
    end do
    
    
    para el polinomio
    
    P=o._wp
    do k=0,n
        L=1._wp
            
            do i=1,n
                if (i/=k) L = L*(C-x(i))/(x(k)-x(i))
            end do
    
        P = P + L * y(k)
    
    end do
    


end program p1