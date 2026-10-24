program OrbitalsAtomicos
 
    implicit none



    real, parameter :: epsilon0 = 0.0   ! energía central
    real, parameter :: V        = 1.0  ! acoplamiento 
    integer :: n, i, Npoints
    real :: t, tmin, tmax, dt
    complex :: Gnn, s, sit
    character(len=*), parameter :: fname = "green.dat"

    ! Pedimos n (cantidad de sitios finitos a la izquierda)
    write(*,*) "Ingrese n (número de orbitales a la izquierda):"
    read(*,*) n
     ! Parámetros de barrido en energía
    tmin = -1.0
    tmax =  2.2
    Npoints = 500
    dt = (tmax - tmin)/real(Npoints-1, wp)
    
    open(unit=10, file=fname, status="replace")
        do i = 1, Npoints
          t = tmin + dt*real(i-1)
        
          s = (t - epsilon0)/2.0 + sqrt(((t - epsilon0)/2.0)**2 - V**2)  
        
          sit = 0.0_wp
          sit = V**2 / (t - epsilon0 - sit(t, n-1))
        
          Gnn = 1.0 / ( t - epsilon0 - sigma_iter(t,n) - sigma(t) )
          write(10,'(3f20.10)') t, real(G), aimag(G)
        end do

    close(10)

   write(*,*) "Datos guardados en ", fname
   write(*,*) "Puede graficar en gnuplot con:"
   write(*,*) "plot 'green.dat' using 1:2 with lines title 'Re[G]', \"
   write(*,*) "     'green.dat' using 1:3 with lines title 'Im[G]'"

end program OrbitalsAtomicos
