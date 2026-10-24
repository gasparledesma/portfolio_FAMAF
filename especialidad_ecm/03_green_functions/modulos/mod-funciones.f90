module funcionessss

use isoprec

contains

!-----------------------------------------------------------------------------------------

function sigma(t)
    implicit none
    real(kind=wp) , intent(in) :: t
    real(kind=wp)              :: sigma
    sigma = (t-ε_0)/2 + sqrt(((t-ε_0)/2)**2-V**2)
end function

!-----------------------------------------------------------------------------------------
!-----------------------------------------------------------------------------------------

function sigmaiter(t,n)
    implicit none
    real(kind=wp) , intent(in) :: t , n
    real(kind=wp)              :: sigmaiter
    sigmaiter = V**2/(t-ε_0-sigmaiter(x,n))
    
end function

!-----------------------------------------------------------------------------------------

function Green(m,x)
    implicit none
    integer(kind=wp) , intent(in) :: m, x
    integer(kind=wp)                 :: Green
    
    Green = 1/(x-ε_0-sigmaiter(x,n)-Σ(x))
end function

!-----------------------------------------------------------------------------------------

end module funciones