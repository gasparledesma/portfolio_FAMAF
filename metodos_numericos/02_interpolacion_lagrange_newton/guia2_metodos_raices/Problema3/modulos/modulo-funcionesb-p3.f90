module funcionesb

    use ISOprec
    ! definicion de la precision global wp
    
    contains
    
     function h(x)
     real(kind=wp), intent(in) :: x
     real(kind=wp) :: h
    
     h = x**2 - 3.0_wp
    
     end function h
    
     ! **************************************************
    
     end module funcionesb
    