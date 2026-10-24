program main_aharonov_bohm
    use isoprec, only : wp
    use mod_dqd_decimation
    implicit none
    
    integer, parameter :: N_E = 2000
    integer :: i
    real(wp) :: E, E_min, E_max, dE
    
    ! Variables físicas
    real(wp) :: E_A, E_B, E_C
    real(wp) :: V_AB, V_AC, V_CB, V_lead
    real(wp) :: pi, alpha_0, alpha_pi
    real(wp) :: T_2st, T_3st_a0, T_3st_api
    
    pi = acos(-1.0_wp)
    
    ! --- PARÁMETROS DEL SISTEMA ---
    V_lead = 2.0_wp
    E_A = 0.0_wp
    E_B = 0.0_wp
    E_C = 0.0_wp
    V_AB = 0.5_wp
    V_AC = 0.5_wp
    V_CB = 0.5_wp
    
    E_min = -4.5_wp
    E_max =  4.5_wp
    
    dE = (E_max - E_min) / real(N_E - 1, kind=wp)
    
    open(unit=10, file='DQD_transmision.dat', status='replace')
    write(10, '(A)') '# Col 1: Energía (E)'
    write(10, '(A)') '# Col 2: Transmisión DQD Simple (Sin estado C)'
    write(10, '(A)') '# Col 3: Transmisión Anillo (Con estado C, Alpha = 0)'
    write(10, '(A)') '# Col 4: Transmisión Anillo (Con estado C, Alpha = Pi)'
    
    do i = 1, N_E
        E = E_min + real(i - 1, kind=wp) * dE
        
        T_2st = calc_transmission(E, E_A, E_B, E_C, V_AB, 0.0_wp, 0.0_wp, V_lead, 0.0_wp)
        
        alpha_0 = 0.0_wp
        T_3st_a0 = calc_transmission(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, alpha_0)
        
        alpha_pi = pi
        T_3st_api = calc_transmission(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, alpha_pi)
        
        write(10, '(4(ES16.8, 2X))') E, T_2st, T_3st_a0, T_3st_api
    end do
    
    close(10)
    print *, "Cálculo exitoso con módulo isoprec."
    print *, "Datos exportados a 'DQD_transmision.dat'."

end program main_aharonov_bohm