program clase

use, intrinsic :: iso_fortran_env, only : int8, int16, int32, int64
use, intrinsic :: iso_fortran_env, only : real32, real64, real128

implicit none

integer(kind=int8) , parameter :: is=int8, id=int16, il=int32, ix=int64
integer(kind=int8) , parameter :: rs=real32, rd=real64, rl=real128

!-----------------------------------------------------------------------------------------

real(kind=rl)                            :: a, b, fa, fb, tol
integer(kind=is)                         :: n, i
real(kind=rl), allocatable, dimension(:) :: v

500 format(A,X,F15.12)
550 format(I2, X, 4(F15.12, X))

!-----------------------------------------------------------------------------------------

a=0._rl
b=0._rl

write(*,*)"Ingrese el valor A"
read(*,*)a
write(*,*)"Ingrese el valor B"
read(*,*)b

if(a>b) then
    write(*,*)"El valor de A debe ser menor al valor de B"
    write(*,*)"No es posible aplicar el método de bisección"
    stop
end if

fa=0._rl
fb=0._rl

fa=f(a)
fb=f(b)

if(sign(1._rl, fa)==sign(1._rl, fb)) then
    write(*,*)"Los valores de la funcion en A y B son iguales"
    write(*,*)"No es posible aplicar el método de bisección"
    stop
end if

tol=0._rl

write(*,*)"Ingrese el valor de tolerancia de error en Y"
read(*,*)tol

if(tol<=0) then
    write(*,*)"La tolerancia no puede ser negativa ni nula"
    write(*,*)"No es posible aplicar el método de bisección"
    stop
end if

n=0

n= floor(log((b-a)/tol)/log(2._rl))+1

allocate(v(n))

if(f(a)<0) then
    do i=1,n,1
      v(i)=a+(b-a)/2
        if(f(v(i))>0) then
            b=v(i)
        else
            a=v(i)
        endif
    end do
else
    do i=1,n,1
        v(i)=a+(b-a)/2
        if(f(v(i))<0) then
            b=v(i)
        else
            a=v(i)
        endif
    end do
end if

write(*,500)"La raiz vale aprox. =",v(n)
write(*,500)"Su valor en funcion vale aprox. =",f(v(n))
write(*,*)"Numero de iteraciones =",n

!-----------------------------------------------------------------------------------------

open(unit=10, file='datos.dat', status='old')

write(10,550) n , v(n) , f(v(n)) , (b-a)/2._rl , (b-a)/(b+a)

close(unit=10)

!-----------------------------------------------------------------------------------------

contains

function f(x)

    implicit none

    real(kind=rl), intent(in) :: x
    real(kind=rl)             :: f

    f = -2._rl*x+tan(x)

end function

!-----------------------------------------------------------------------------------------

end program clase
