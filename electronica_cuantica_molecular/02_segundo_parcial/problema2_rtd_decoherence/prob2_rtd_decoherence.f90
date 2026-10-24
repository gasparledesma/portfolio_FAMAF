program main_rtd_decoherence
    use isoprec, only : wp
    use mod_dp_wbl
    implicit none
    
    integer, parameter :: n_pts = 2000
    integer :: i
    real(wp) :: E, E_start, E_end, dE
    
    ! Parámetros
    real(wp) :: E0, GamL, GamR
    real(wp) :: Tc_0, Ti_0, Tt_0  ! Caso 1: Totalmente Coherente
    real(wp) :: Tc_1, Ti_1, Tt_1  ! Caso 2: Decoherencia Moderada
    real(wp) :: Tc_2, Ti_2, Tt_2  ! Caso 3: Decoherencia Fuerte
    
    E0 = 0.0_wp
    GamL = 0.5_wp
    GamR = 0.5_wp
    
    ! Rango de energía
    E_start = -5.0_wp
    E_end = 5.0_wp
    dE = (E_end - E_start) / real(n_pts - 1, kind=wp)
    
    open(unit=10, file='datos/rtd_transmittance.dat', status='replace')
    
    write(10, '(A)') '# Col 1: Energia(E)'
    write(10, '(A)') '# --- Gamma_Phi = 0.0 ---'
    write(10, '(A)') '# Col 2: T_tot(=T_coh)'
    write(10, '(A)') '# --- Gamma_Phi = 0.5 ---'
    write(10, '(A)') '# Col 3: T_tot | Col 4: T_coh | Col 5: T_inc'
    write(10, '(A)') '# --- Gamma_Phi = 2.0 ---'
    write(10, '(A)') '# Col 6: T_tot | Col 7: T_coh | Col 8: T_inc'
    write(10, '(A)') '# ----------------------------------------------------'
    
    do i = 1, n_pts
        E = E_start + real(i - 1, kind=wp) * dE
        
        
        call calc_transmittances(E, E0, GamL, GamR, 0.0_wp, Tc_0, Ti_0, Tt_0)
        call calc_transmittances(E, E0, GamL, GamR, 0.5_wp, Tc_1, Ti_1, Tt_1)
        call calc_transmittances(E, E0, GamL, GamR, 2.0_wp, Tc_2, Ti_2, Tt_2)
        
        
        write(10, '(8(ES15.6, 2X))') E, Tt_0, Tt_1, Tc_1, Ti_1, Tt_2, Tc_2, Ti_2
    end do
    
    close(10)
    print *, "Cálculo finalizado exitosamente."
    print *, "Datos exportados a 'datos/rtd_transmittance.dat'."

end program main_rtd_decoherence