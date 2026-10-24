module funciones

use ISO
	function fa(x)

		implicit none 
		real (kind=wp), intent (in) :: x
		real(kind=wp) :: fa

		fa = 2._wp*x+tan(x)

	end function

	function dfa(x)

		implicit none 
		real (kind=wp), intent (in) :: x
		real(kind=wp) :: dfa

		dfa = 2._wp+1./((cos(x))**2)

	end function


	function fb(x)

		implicit none 
		real (kind=wp), intent (in) :: x
		real(kind=wp) :: fb

		fb = 2._wp*x-tan(x)

	end function

	function dfb(x)

		implicit none 
		real (kind=wp), intent (in) :: x
		real(kind=wp) :: dfb

		dfb = 2._wp+1./((cos(x))**2)

	end function

 end module funciones
