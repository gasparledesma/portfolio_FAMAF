program OrbitalsAtomicos
  implicit none

  ! doble precisión
  integer, parameter :: dp = selected_real_kind(15,307)
  real(dp), parameter :: epsilon0 = 0.0_dp   ! energía central ε0
  real(dp), parameter :: V        = 1.0_dp   ! acoplamiento V
  real(dp), parameter :: eta      = 1.0e-6_dp ! ancho imaginario pequeño (i0+)
  integer :: n, i, j, Npoints, unit
  real(dp) :: t, tmin, tmax, dt
  complex(dp) :: G, sigma, tc, cf, denom, s, arg
  character(len=*), parameter :: fname = "green.dat"

  ! lectura de n
  write(*,*) "Ingrese n (numero de orbitales a la izquierda, entero >= 1):"
  read(*,*) n
  if (n < 1) then
     write(*,*) "n debe ser >= 1. Saliendo."
     stop
  end if

  ! parámetros de barrido en energía
  tmin = -1.0_dp
  tmax =  2.2_dp
  Npoints = 500
  dt = (tmax - tmin) / real(Npoints-1, dp)

  open(newunit=unit, file=fname, status="replace", action="write", form="formatted")

  do i = 1, Npoints
    t = tmin + dt*real(i-1, dp)

    ! convertimos energía a complejo añadiendo i*eta (retarded GF)
    tc = cmplx(t, eta, dp)

    ! calculo de Sigma(tc) = (tc-eps)/2 + sqrt(((tc-eps)/2)**2 - V**2)
    s = (tc - cmplx(epsilon0,0.0_dp,dp)) / 2.0_dp
    arg = s*s - cmplx(V*V, 0.0_dp, dp)
    sigma = s + sqrt(arg)    ! <<-- usar sqrt en lugar de csqrt

    ! calculo de la fraccion continua CF para n sitios:
    cf = cmplx(0.0_dp, 0.0_dp, dp)
    if (n >= 2) then
      do j = 1, n-1
        denom = tc - cmplx(epsilon0, 0.0_dp, dp) - cf
        cf = cmplx(V*V, 0.0_dp, dp) / denom
      end do
    end if

    ! función de Green G = 1 / ( tc - eps - CF - Sigma )
    G = 1.0_dp / ( tc - cmplx(epsilon0,0.0_dp,dp) - cf - sigma )

    ! escribimos: columna 1 = t (real), 2 = Re[G], 3 = Im[G]
    write(unit,'(3(1x,E18.10))') t, real(G), aimag(G)
  end do

  close(unit)

  write(*,*) "Datos guardados en ", trim(fname)
  write(*,*) "Puede graficar en gnuplot con:"
  write(*,*) "plot 'green.dat' using 1:2 with lines title 'Re[G]', \\"
  write(*,*) "     'green.dat' using 1:3 with lines title 'Im[G]'"

end program OrbitalsAtomicos
