module mod_dqd_decimation
    use isoprec, only : wp
    use mod_tight_binding_leads
    implicit none
    
    complex(wp), parameter :: im = cmplx(0.0_wp, 1.0_wp, kind=wp)

contains

    function calc_transmission(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, alpha) result(T)
        real(wp), intent(in) :: E, E_A, E_B, E_C
        real(wp), intent(in) :: V_AB, V_AC, V_CB, V_lead, alpha
        real(wp) :: T
        
        complex(wp) :: E_c_cmplx
        complex(wp) :: eA_eff, eB_eff, V_AB_eff, V_BA_eff
        complex(wp) :: Sigma_L, Sigma_R
        real(wp)    :: Gam_L, Gam_R
        complex(wp) :: det_G, G_BA

        Sigma_L = calc_sigma_retarded(E, V_lead)
        Sigma_R = calc_sigma_retarded(E, V_lead)
        Gam_L = -2.0_wp * aimag(Sigma_L)
        Gam_R = -2.0_wp * aimag(Sigma_R)
        
        E_c_cmplx = cmplx(E_C, -1e-12_wp, kind=wp)

        eA_eff = E_A + (V_AC**2) / (E - E_c_cmplx)
        eB_eff = E_B + (V_CB**2) / (E - E_c_cmplx)

        V_AB_eff = V_AB * exp(im * alpha)  + (V_AC * V_CB) / (E - E_c_cmplx)
        V_BA_eff = V_AB * exp(-im * alpha) + (V_CB * V_AC) / (E - E_c_cmplx)

        det_G = (E - eA_eff - Sigma_L) * (E - eB_eff - Sigma_R) - (V_AB_eff * V_BA_eff)
        
        G_BA = V_BA_eff / det_G

        T = Gam_L * Gam_R * abs(G_BA)**2
        
    end function calc_transmission

end module mod_dqd_decimation