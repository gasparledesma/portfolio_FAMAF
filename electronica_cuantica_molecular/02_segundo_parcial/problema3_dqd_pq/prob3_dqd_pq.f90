program main_prob3
    use isoprec, only : wp
    use mod_dqd_dp_exacto
    implicit none
    
    integer, parameter :: n_pts = 2000
    integer :: i
    real(wp) :: E, E_start, E_end, dE
    
    ! Parámetros
    real(wp), parameter :: V_lead = 2.0_wp
    real(wp), parameter :: E_A = 0.0_wp, E_B = 0.0_wp, E_C = 0.0_wp
    real(wp), parameter :: V_AB = 1.0_wp, V_AC = 1.0_wp, V_CB = 1.0_wp
    real(wp), parameter :: alpha = 3.141592653589793_wp ! Fase Pi -> Antiresonancia en E=1
    
    real(wp) :: Tc_0, Ti_0, Tt_0  ! GamPh = 0.0
    real(wp) :: Tc_1, Ti_1, Tt_1  ! GamPh = 0.5
    real(wp) :: Tc_2, Ti_2, Tt_2  ! GamPh = 2.0
    
    E_start = -4.5_wp
    E_end = 4.5_wp
    dE = (E_end - E_start) / real(n_pts - 1, wp)
    
    open(unit=10, file='datos/dqd_dp_exacto.dat', status='replace')
    write(10, '(A)') '# Col 1: Energia(E)'
    write(10, '(A)') '# Col 2: T_tot(G_phi=0.0)'
    write(10, '(A)') '# Col 3: T_tot(G_phi=0.5) | Col 4: T_coh(0.5) | Col 5: T_inc(0.5)'
    write(10, '(A)') '# Col 6: T_tot(G_phi=2.0) | Col 7: T_coh(2.0) | Col 8: T_inc(2.0)'
    
    do i = 1, n_pts
        E = E_start + real(i - 1, wp) * dE
        
        call calc_dp_multiterminal(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, 0.0_wp, alpha, Tc_0, Ti_0, Tt_0)
        call calc_dp_multiterminal(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, 0.5_wp, alpha, Tc_1, Ti_1, Tt_1)
        call calc_dp_multiterminal(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, 2.0_wp, alpha, Tc_2, Ti_2, Tt_2)
        
        write(10, '(8(F12.6, 2X))') E, Tt_0, Tt_1, Tc_1, Ti_1, Tt_2, Tc_2, Ti_2
    end do
    
    close(10)
    print *, "Cálculo finalizado. Datos exportados a 'datos/dqd_dp_exacto.dat'."
end program main_prob3