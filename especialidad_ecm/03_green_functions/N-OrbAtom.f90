program OrbitalsAtomicos

use isoprec
use funciones

implicit none

!-----------------------------------------------------------------------------------------

integer(kind=il) :: n, m, G
integer          :: iter

write(*,*)"Ingrese el número:"
read(*,*)n 
write(*,*)"Ingrese el segundo número:"
read(*,*)m


iter=1

if(a==b) then
        do
            G = MCDEuclides(a,b)
            a=b
            b=r
            iter=iter+1
        end do
end if

end program OrbitalsAtomicos