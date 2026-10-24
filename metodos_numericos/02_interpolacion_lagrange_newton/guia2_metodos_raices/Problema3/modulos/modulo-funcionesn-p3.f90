module funcionesn

    use  ISOprec    ! definicion de la precision global wp
   
    contains
   
   ! ***********************************************************
    
    function g(x)
    
   
    implicit none
    real( kind = wp ) , intent(in) :: x
    real( kind = wp )     :: g
   
   
   
   
    g = x**2 - 3._wp
   
   
    end function
   
   ! ************************************************************
   
   
    function  dgdx ( x )
   
    implicit  none
   
    real( kind = wp ) , intent(in) :: x
    real( kind = wp )   :: dgdx
   
   
    dgdx = 2._wp * x
   
    end function

    end module funcionesn
   
   
   
   