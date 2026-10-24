module mod_fock_phonon
    use isoprec, only : wp
    implicit none
    complex(wp), parameter :: im = cmplx(0.0_wp, 1.0_wp, kind=wp)

contains

    ! Autoenergía exacta para un sitio acoplado a un electrodo 1D
    function calc_sigma_retarded(E, V_lead, V_c) result(sigma)
        real(wp), intent(in) :: E, V_lead, V_c
        complex(wp) :: sigma, z, root_val
        z = cmplx(E, 1e-7_wp, kind=wp)
        
        root_val = sqrt(z**2 - 4.0_wp * V_lead**2)
        ! (Im(Sigma) < 0)
        if (aimag(root_val) < 0.0_wp) root_val = -root_val
        
        ! V_c controla la altura de las barreras del DBRTD
        sigma = (V_c**2) * (z - root_val) / (2.0_wp * V_lead**2)
    end function calc_sigma_retarded

    ! transporte inelástico truncado a +-1 fonón
    subroutine calc_inelastic_transport(E, E_r, w0, Vg, n_phonons, V_lead, V_c, T_el, T_em, T_abs)
        real(wp), intent(in) :: E, E_r, w0, Vg, n_phonons, V_lead, V_c
        real(wp), intent(out) :: T_el, T_em, T_abs
        
        complex(wp) :: Z(3,3), G(3,3)
        complex(wp) :: Sig_el, Sig_em, Sig_abs
        real(wp) :: Gam_el, Gam_em, Gam_abs
        complex(wp) :: detZ
        
        !Autoenergías a las 3 energías posibles de salida
        Sig_el  = calc_sigma_retarded(E, V_lead, V_c)
        Sig_em  = calc_sigma_retarded(E - w0, V_lead, V_c)
        Sig_abs = calc_sigma_retarded(E + w0, V_lead, V_c)
        
        Gam_el  = -2.0_wp * aimag(Sig_el)
        Gam_em  = -2.0_wp * aimag(Sig_em)
        Gam_abs = -2.0_wp * aimag(Sig_abs)
        
        !Construcción de Matriz Resolvente en Espacio de Fock
        Z = 0.0_wp
        Z(1,1) = (E + w0) - E_r - 2.0_wp * Sig_abs
        Z(2,2) = E - E_r - 2.0_wp * Sig_el
        Z(3,3) = (E - w0) - E_r - 2.0_wp * Sig_em
        
        ! Acoplamientos electrón-fonón
        Z(2,1) = -Vg * sqrt(n_phonons);          Z(1,2) = Z(2,1)
        Z(2,3) = -Vg * sqrt(n_phonons + 1.0_wp); Z(3,2) = Z(2,3)
        

        detZ = Z(1,1)*(Z(2,2)*Z(3,3) - Z(2,3)*Z(3,2)) - Z(1,2)*(Z(2,1)*Z(3,3) - Z(2,3)*Z(3,1)) + Z(1,3)*(Z(2,1)*Z(3,2) - Z(2,2)*Z(3,1))
        
        G(2,2) = (Z(1,1)*Z(3,3) - Z(1,3)*Z(3,1)) / detZ
        G(3,2) = (Z(1,2)*Z(3,1) - Z(1,1)*Z(3,2)) / detZ
        G(1,2) = (Z(1,3)*Z(3,2) - Z(1,2)*Z(3,3)) / detZ
        
        !Transmitancias inelásticas de Fisher-Lee
        T_el  = Gam_el * Gam_el * abs(G(2,2))**2
        T_em  = Gam_em * Gam_el * abs(G(3,2))**2
        T_abs = Gam_abs * Gam_el * abs(G(1,2))**2
        
    end subroutine calc_inelastic_transport

end module mod_fock_phonon