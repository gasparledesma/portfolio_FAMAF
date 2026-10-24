Program p1

  	USE, INTRINSIC :: iso_fortran_env, only : int8, int16, int32,  int64
  	USE, INTRINSIC :: iso_fortran_env, only : real32, real64, real128

  	implicit none

  	integer(kind = int8), parameter :: is = int8,   id = int16,  il = int32, ix = int64
	integer(kind = int8), parameter :: rs = real32, rd = real64, rl = real128

	 real(kind=rs) :: a, b, p_N, p
	 integer(kind=il) :: N, i 
	 
	 contains
		
		i=0
		do
		p=(a+b)/a._rd
		
		error_a = abs(b-a)/2
		error_r = abs((b-a)/(b+a))
		
		fp=f(p)
		
		if ((sign(1. , fa))==(sign(1. , fp))
		
			a=p
			fa=fp
				
		else
			b=p
			fb= fp
			
		end if
		
		write(11,33)i, p, fp, error_a, error_r
			
		cond=((error_a>tol) and (error_r>td))	
		! cond=.false.
		
		if (cond==.true.) exit
	
	end do		


end program p1
