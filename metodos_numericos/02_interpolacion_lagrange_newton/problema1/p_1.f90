program p1

    use ISOprec
    USE funciones

    write(*,*) P1
    write(*,*) P2

    open(unit=13, file='datos/p1-funciones.dat')
    t=a
    do i=0, 600
    t=a+i*abs(b-a)/600
    write(13,*) t, P1, P2, deltax
    end do
    
    close(unit=13)
        

end program p1    