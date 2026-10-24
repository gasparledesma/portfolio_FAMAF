program main_prob4_polaron
    use isoprec, only : wp
    use mod_fock_phonon
    implicit none
    
    integer, parameter :: n_pts = 4000
    integer :: i
    real(wp) :: E, E_start, E_end, dE
    
    ! Parámetros
    real(wp), parameter :: V_lead = 3.0_wp    
    real(wp), parameter :: V_c = 0.5_wp       
    real(wp), parameter :: E_r = 0.0_wp       ! Nivel resonante
    real(wp), parameter :: w0 = 1.0_wp        
    real(wp), parameter :: Vg = 0.4_wp        ! Acoplamiento e-ph
    real(wp), parameter :: n_phonons = 1.0_wp ! Oscilador clásico
    
    real(wp) :: Tel, Tem, Tabs, Ttot
    
    E_start = -3.5_wp
    E_end = 3.5_wp
    dE = (E_end - E_start) / real(n_pts - 1, wp)
    
    open(unit=10, file='datos/fock_inelastic.dat', status='replace')
    write(10, '(A)') '# Col 1: Energia(E) | Col 2: T_Elastica | Col 3: T_Emision | Col 4: T_Absorcion | Col 5: T_Total'
    
    do i = 1, n_pts
        E = E_start + real(i - 1, wp) * dE
        
        call calc_inelastic_transport(E, E_r, w0, Vg, n_phonons, V_lead, V_c, Tel, Tem, Tabs)
        Ttot = Tel + Tem + Tabs
        
        write(10, '(5(F14.8, 2X))') E, Tel, Tem, Tabs, Ttot
    end do
    
    close(10)
    print *, "Datos generados exitosamente en 'datos/fock_inelastic.dat'."
end program main_prob4_polaron