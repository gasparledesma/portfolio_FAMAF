module funciones

    use  ISOprec    ! definicion de la precision global wp
   
    contains
   
   ! ***********************************************************
    
    function P1(x)
    
   
    implicit none
    real( kind = wp ) , intent(in) :: x
    real( kind = wp )     :: P1
   
   
    P1 = log(1.6_wp)*(((x)*(x-0.9_wp))/(0.6_wp*(-0.3_wp)))+log(1.9)*((x*(x-0.6_wp))/(0.9_wp*0.3_wp))
   
   
    end function
   
   ! ************************************************************
   
   
    function  P2 ( x )
   
    implicit  none
   
    real( kind = wp ) , intent(in) :: x
    real( kind = wp )   :: P2
   
   
    P2=sqrt(0.6)*(((x)*(x-0.9_wp))/(0.6_wp*(-0.3_wp)))+sqrt(0.9)*((x*(x-0.6_wp))/(0.9_wp*0.3_wp))
   
    end function

    end module funciones
   
   
   
   