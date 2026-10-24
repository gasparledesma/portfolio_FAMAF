program OrbitalsAtomicos
   use isoprec
   use funciones
   implicit none

   integer :: n, i, Npoints
   real(kind=wp) :: t, tmin, tmax, dt
   complex(kind=wp) :: G
   character(len=*), parameter :: fname = "green.dat"

   ! Pedimos n (cantidad de sitios finitos a la izquierda)
   write(*,*) "Ingrese n (número de orbitales a la izquierda):"
   read(*,*) n

   ! Parámetros de barrido en energía
   tmin = -1.0_wp
   tmax =  2.2_wp
   Npoints = 500
   dt = (tmax - tmin)/real(Npoints-1, wp)

   open(unit=10, file=fname, status="replace")

   do i = 1, Npoints
      t = tmin + dt*real(i-1, wp)
      G = Green(t,n)
      write(10,'(3f20.10)') t, real(G), aimag(G)
   end do

   close(10)

   write(*,*) "Datos guardados en ", fname
   write(*,*) "Puede graficar en gnuplot con:"
   write(*,*) "plot 'green.dat' using 1:2 with lines title 'Re[G]', \"
   write(*,*) "     'green.dat' using 1:3 with lines title 'Im[G]'"

end program OrbitalsAtomicos
