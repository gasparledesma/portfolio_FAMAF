module mod_dp_wbl
    use isoprec, only : wp
    implicit none

contains

    ! Subrutina para calcular la transmitancia coherente, incoherente y total
    subroutine calc_transmittances(E, E0, GamL, GamR, GamPhi, T_coh, T_inc, T_tot)
        real(wp), intent(in)  :: E, E0, GamL, GamR, GamPhi
        real(wp), intent(out) :: T_coh, T_inc, T_tot
        
        real(wp) :: mod_G2      ! Módulo al cuadrado de la Función de Green
        real(wp) :: Gamma_tot   ! Ensanchamiento total

        ! Ensanchamiento total fenomenológico
        Gamma_tot = GamL + GamR + GamPhi
        
        ! Cuadrado del módulo de la Función de Green retardada evaluada en el sitio
        mod_G2 = 1.0_wp / ((E - E0)**2 + Gamma_tot**2)
        
        ! 1. Transmitancia puramente coherente (Fórmula de Fisher-Lee directa)
        T_coh = 4.0_wp * GamL * GamR * mod_G2
        
        ! 2. Transmitancia incoherente (Modelo DP: Electrones reinyectados sin fase)
        if (GamL + GamR > 0.0_wp) then
            T_inc = T_coh * (GamPhi / (GamL + GamR))
        else
            T_inc = 0.0_wp
        end if
        
        ! 3. Transmitancia total efectiva
        T_tot = T_coh + T_inc
        
    end subroutine calc_transmittances

end module mod_dp_wbl