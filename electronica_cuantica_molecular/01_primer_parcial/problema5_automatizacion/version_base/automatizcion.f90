program problema5ab_hofstadter_autom
    use isoprec
    use functions
    implicit none

    ! --- 1. DECLARACIONES ---
    integer, parameter :: N_energy = 4000
    integer, parameter :: N_total = 100 
    integer :: k, stat, n_sitio
    integer :: i_q, i_w  ! Indices para los bucles de parametros
    
    ! Parametros Fisicos
    real(kind=wp) :: V = 1.0_wp 
    real(kind=wp) :: a = 1.0_wp
    
    ! --- ARRAYS DE PARAMETROS ---
    real(kind=wp), dimension(3) :: W_list = (/ 0.5_wp, 2.0_wp, 3.0_wp /)
    real(kind=wp), dimension(2) :: Q_list
    real(kind=wp) :: W_act, Q_act

    ! Parametros de los Cables (Con contactos anchos B=8V)
    real(kind=wp) :: ep_lead = 0.0_wp    
    real(kind=wp) :: V_L = 2.0_wp        
    real(kind=wp) :: V_R = 2.0_wp     

    ! Variables de Energia
    real(kind=wp) :: E, dE, E_min, E_max, eta = 0.0001_wp
    complex(kind=wp) :: z

    ! Variables Auxiliares Green / Sigma
    complex(kind=wp) :: Sig_L, Sig_R, G_nn
    complex(kind=wp) :: Sig_Cable_L, Sig_Cable_R, Sig_Cadena_Acumulada
    real(kind=wp)    :: ep_n
    real(kind=wp)    :: Gam_L_eff, Gam_R_phys

    ! --- MATRICES DE RESULTADOS (4 variables x 6 combinaciones) ---
    real(kind=wp) :: res_DOS(2, 3)
    real(kind=wp) :: res_Trans(2, 3)
    real(kind=wp) :: res_N_E(2, 3)      ! NUEVO: Densidad Acumulada N(E)
    real(kind=wp) :: res_inv_loc(2, 3)  ! NUEVO: Inversa long. localizacion \delta(E)
    
    real(kind=wp) :: dens_acumulada, trans_temp

    ! --- CONFIGURACION ---
    call execute_command_line("mkdir datos", exitstat=stat) 
    
    open(20, file='datos/todos_los_datos.dat')
    
    ! Escribimos un encabezado explicativo (25 columnas en total)
    write(20, '(A)', advance='no') "# E  "
    
    do i_q = 1, 2
        do i_w = 1, 3
            write(20, '(A,I1,A,I1, A,I1,A,I1, A,I1,A,I1, A,I1,A,I1)', advance='no') &
                  "   DOS_Q", i_q, "W", i_w, &
                  "   N(E)_Q", i_q, "W", i_w, &
                  "   T_Q", i_q, "W", i_w, &
                  "   del_Q", i_q, "W", i_w
        end do
    end do
    write(20, *) "" ! Salto de linea final del encabezado

    ! Definir valores de Q
    Q_list(1) = 2.0_wp / a 
    Q_list(2) = 2.0_wp * 3.14159265359_wp / (3.0_wp * a)

    E_min = -4.0_wp
    E_max = 4.0_wp
    dE = (E_max - E_min) / real(N_energy, kind=wp)

    ! NUEVO: Inicializamos la integral acumulada en cero
    res_N_E = 0.0_wp

    ! === BUCLE DE ENERGÍA ===
    print *, "Calculando... Por favor espere."
    
    do k = 0, N_energy
        E = E_min + real(k, kind=wp) * dE
        z = cmplx(E, eta, kind=wp)

        ! Calculamos Sigmas de los cables
        Sig_Cable_L = (V_L/V)**2 * sigma1(E, ep_lead, V)
        Sig_Cable_R = (V_R/V)**2 * sigma1(E, ep_lead, V)
        Gam_R_phys  = -aimag(Sig_Cable_R)

        ! --- BUCLES SOBRE PARAMETROS (Q y W) ---
        do i_q = 1, 2
            do i_w = 1, 3
                
                Q_act = Q_list(i_q)
                W_act = W_list(i_w)

                ! 1. CALCULO DE DOS Y DENSIDAD ACUMULADA N(E)
                ! -------------------------------------------
                dens_acumulada = 0.0_wp
                do n_sitio = 1, N_total
                    ep_n  = e_Hofstadter(n_sitio, W_act, Q_act)
                    Sig_L = sigma_izquierda_Hof(n_sitio, z, W_act, Q_act, V)
                    Sig_R = sigma_derecha_Hof(n_sitio, N_total, z, W_act, Q_act, V)
                    
                    G_nn  = Green_nn_Hof(z, ep_n, Sig_L, Sig_R)
                    dens_acumulada = dens_acumulada + (-1.0_wp/3.14159265359_wp)*aimag(G_nn)
                end do
                res_DOS(i_q, i_w) = dens_acumulada
                
                ! Suma acumulativa para integrar N(E) = \int DOS dE
                res_N_E(i_q, i_w) = res_N_E(i_q, i_w) + (dens_acumulada * dE)

                ! 2. CALCULO DE TRANSMISION Y \delta(E)
                ! -------------------------------------
                Sig_Cadena_Acumulada = sigma_izquierda_con_init(N_total, z, W_act, Q_act, V, Sig_Cable_L)
                ep_n = e_Hofstadter(N_total, W_act, Q_act)
                G_nn = 1.0_wp / (z - ep_n - Sig_Cadena_Acumulada - Sig_Cable_R)
                
                Gam_L_eff = -aimag(Sig_Cadena_Acumulada)
                
                trans_temp = 4.0_wp * Gam_L_eff * Gam_R_phys * (abs(G_nn)**2)
                res_Trans(i_q, i_w) = trans_temp

                ! Inversa de la longitud de localizacion \delta(E) = -ln(T) / 2N
                res_inv_loc(i_q, i_w) = -log(max(trans_temp, 1e-100_wp)) / (2.0_wp * real(N_total, kind=wp))

            end do
        end do

        ! --- ESCRITURA EN ARCHIVO (25 columnas) ---
        ! Formato: E, luego iteramos los arrays (DOS, N(E), T, \delta) para cada caso
        write(20, '(25ES16.7)') E, &
             ((res_DOS(i_q, i_w), res_N_E(i_q, i_w), res_Trans(i_q, i_w), res_inv_loc(i_q, i_w), i_w=1,3), i_q=1,2)
             
    end do
    
    close(20)
    print *, "--------------------------------------------------------"
    print *, "Generado: datos/todos_los_datos.dat"
    print *, "El archivo tiene 25 columnas: E, luego cuartetos de:"
    print *, "DOS, N(E), Transmision, \delta(E) para cada caso Q y W."
    print *, "--------------------------------------------------------"

end program problema5ab_hofstadter_autom