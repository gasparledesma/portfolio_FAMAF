module mod_tight_binding_leads
    use isoprec, only : wp
    implicit none

contains

    ! Calcula la autoenergía retardada Sigma_R(E)
    function calc_sigma_retarded(E, V_lead) result(sigma)
        real(wp), intent(in) :: E, V_lead
        complex(wp) :: sigma, z, root_val
        
        ! Se añade un infinitésimo imaginario para garantizar la causalidad
        z = cmplx(E, 1e-7_wp, kind=wp)
        
        ! Raíz cuadrada del denominador de la resolvente
        root_val = sqrt(z**2 - 4.0_wp * V_lead**2)
        
        ! Prescripción para la función de Green retardada
        if (aimag(root_val) > 0.0_wp) root_val = -root_val
        
        sigma = (z - root_val) / 2.0_wp
    end function calc_sigma_retarded

end module mod_tight_binding_leads