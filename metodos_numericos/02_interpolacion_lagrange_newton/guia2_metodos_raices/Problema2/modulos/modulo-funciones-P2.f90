 module funciones

 use  ISOprec    ! definicion de la precision global wp

 contains


! ***********************************************************

 function  fa(x)

 implicit none
 
 real ( kind = wp ) , intent(in) :: x
 real ( kind = wp ) :: fa


 fa = 2._wp * x - tan(x)

 end function
 
 
 ! ***********************************************************
 

  function  dfadx ( x )

  implicit none
  
  real(kind = wp) , intent(in) :: x
  real(kind = wp)  :: dfadx



  dfadx = 2._wp - 1._wp/cos(x)**2

  end function


! ***********************************************************
 
 function fb1(x)
 

 implicit none
 real( kind = wp ) , intent(in) :: x
 real( kind = wp )     :: fb1




 fb1 = x**2 - 3._wp


 end function

! ************************************************************


 function  dfb1dx ( x )

 implicit  none

 real( kind = wp ) , intent(in) :: x
 real( kind = wp )   :: dfb1dx


 dfb1dx = 2._wp * x

 end function
 
 
! ************************************************************


 function  fb2 ( x )

 
 implicit none
 
 real( kind = wp ) ,intent(in) :: x
 real( kind = wp )  :: fb2


 fb2 = x - 3._wp/x

 end function
 
! ***************************************************************


 function dfb2dx ( x )

 implicit none

 real( kind = wp ) , intent (in) :: x
 real( kind = wp ) :: dfb2dx


 dfb2dx = 1._wp + 3._wp/x**2

 end function
 
 
! ****************************************************************

 end module funciones



