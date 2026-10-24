module mod_dqd_dp_exacto
    use isoprec, only : wp
    implicit none
    complex(wp), parameter :: im = cmplx(0.0_wp, 1.0_wp, kind=wp)

contains

    ! Autoenergía exacta para electrodos 1D semi-infinitos
    function calc_sigma_retarded(E, V_lead) result(sigma)
        real(wp), intent(in) :: E, V_lead
        complex(wp) :: sigma, z, root_val
        z = cmplx(E, 1e-7_wp, kind=wp)
        root_val = sqrt(z**2 - 4.0_wp * V_lead**2)
        if (aimag(root_val) > 0.0_wp) root_val = -root_val
        sigma = (z - root_val) / 2.0_wp
    end function calc_sigma_retarded

    ! Transmitancia Multieterminal D'Amato-Pastawski
    subroutine calc_dp_multiterminal(E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, &
                                     GamPh, alpha, T_coh, T_inc, T_tot)
        real(wp), intent(in)  :: E, E_A, E_B, E_C, V_AB, V_AC, V_CB, V_lead, GamPh, alpha
        real(wp), intent(out) :: T_coh, T_inc, T_tot
        
        complex(wp) :: SigL, SigR
        real(wp)    :: GamL, GamR
        complex(wp) :: H_eff(3,3), G(3,3)
        real(wp)    :: T(5,5) ! Indices: 1=L, 2=R, 3=PhiA, 4=PhiB, 5=PhiC
        real(wp)    :: W(3,3), invW(3,3)
        real(wp)    :: S(3)
        integer     :: m, n, k
        
        SigL = calc_sigma_retarded(E, V_lead)
        SigR = calc_sigma_retarded(E, V_lead)
        GamL = -2.0_wp * aimag(SigL)
        GamR = -2.0_wp * aimag(SigR)
        
        !Hamiltoniano Efectivo Z = (E*I - H_eff)
        H_eff = 0.0_wp
        H_eff(1,1) = E - E_A - SigL - 0.5_wp * im * GamPh
        H_eff(2,2) = E - E_B - SigR - 0.5_wp * im * GamPh
        H_eff(3,3) = E - E_C        - 0.5_wp * im * GamPh
        
        H_eff(1,2) = -V_AB * exp(im * alpha)
        H_eff(2,1) = -V_AB * exp(-im * alpha)
        H_eff(1,3) = -V_AC; H_eff(3,1) = -V_AC
        H_eff(2,3) = -V_CB; H_eff(3,2) = -V_CB
        
        G = invert_3x3_c(H_eff)
        
        ! transmitancias T(hacia, desde) de Fisher-Lee
        
        T = 0.0_wp
        ! Coherente pura L -> R
        T(2,1) = GamR * GamL * abs(G(2,1))**2
        T_coh = T(2,1)
        
        ! Si no hay decoherencia, cortamos el cálculo aquí
        if (GamPh < 1e-12_wp) then
            T_inc = 0.0_wp
            T_tot = T_coh
            return
        end if
        
        ! Transmitancias Involucrando Sondas Phi
        ! L -> Phi_m
        T(3,1) = GamPh * GamL * abs(G(1,1))**2  ! L -> PhiA
        T(4,1) = GamPh * GamL * abs(G(2,1))**2  ! L -> PhiB
        T(5,1) = GamPh * GamL * abs(G(3,1))**2  ! L -> PhiC
        
        ! Phi_m -> R
        T(2,3) = GamR * GamPh * abs(G(2,1))**2  ! PhiA -> R
        T(2,4) = GamR * GamPh * abs(G(2,2))**2  ! PhiB -> R
        T(2,5) = GamR * GamPh * abs(G(2,3))**2  ! PhiC -> R
        
        ! Phi_n -> Phi_m
        T(3,3) = GamPh * GamPh * abs(G(1,1))**2; T(3,4) = GamPh * GamPh * abs(G(1,2))**2; T(3,5) = GamPh * GamPh * abs(G(1,3))**2
        T(4,3) = GamPh * GamPh * abs(G(2,1))**2; T(4,4) = GamPh * GamPh * abs(G(2,2))**2; T(4,5) = GamPh * GamPh * abs(G(2,3))**2
        T(5,3) = GamPh * GamPh * abs(G(3,1))**2; T(5,4) = GamPh * GamPh * abs(G(3,2))**2; T(5,5) = GamPh * GamPh * abs(G(3,3))**2
        
        ! Matriz DP multieterminal (W)
        ! Para m,n en {1,2,3} que corresponden a los índices {3,4,5} en la matriz T
        W = 0.0_wp
        do m = 1, 3
            ! Flujo de salida total desde m (S_m)
            S(m) = T(1, m+2) + T(2, m+2) + T(3, m+2) + T(4, m+2) + T(5, m+2)
            do n = 1, 3
                if (m == n) then
                    W(m,n) = S(m) - T(m+2, n+2)
                else
                    W(m,n) = -T(m+2, n+2)
                end if
            end do
        end do
        
        ! Invertimos W y calculamos Transmitancia Incoherente
        invW = invert_3x3_r(W)
        
        T_inc = 0.0_wp
        do m = 1, 3
            do n = 1, 3
                T_inc = T_inc + T(2, m+2) * invW(m,n) * T(n+2, 1)
            end do
        end do
        
        T_tot = T_coh + T_inc

    end subroutine calc_dp_multiterminal

    ! ================= FUNCIONES AUXILIARES DE INVERSIÓN =================
    function invert_3x3_c(A) result(invA)
        complex(wp), intent(in) :: A(3,3)
        complex(wp) :: invA(3,3)
        complex(wp) :: det
        det = A(1,1)*(A(2,2)*A(3,3) - A(2,3)*A(3,2)) - A(1,2)*(A(2,1)*A(3,3) - A(2,3)*A(3,1)) + A(1,3)*(A(2,1)*A(3,2) - A(2,2)*A(3,1))
        invA(1,1) = (A(2,2)*A(3,3) - A(2,3)*A(3,2)) / det; invA(1,2) = (A(1,3)*A(3,2) - A(1,2)*A(3,3)) / det; invA(1,3) = (A(1,2)*A(2,3) - A(1,3)*A(2,2)) / det
        invA(2,1) = (A(2,3)*A(3,1) - A(2,1)*A(3,3)) / det; invA(2,2) = (A(1,1)*A(3,3) - A(1,3)*A(3,1)) / det; invA(2,3) = (A(1,3)*A(2,1) - A(1,1)*A(2,3)) / det
        invA(3,1) = (A(2,1)*A(3,2) - A(2,2)*A(3,1)) / det; invA(3,2) = (A(1,2)*A(3,1) - A(1,1)*A(3,2)) / det; invA(3,3) = (A(1,1)*A(2,2) - A(1,2)*A(2,1)) / det
    end function invert_3x3_c

    function invert_3x3_r(A) result(invA)
        real(wp), intent(in) :: A(3,3)
        real(wp) :: invA(3,3)
        real(wp) :: det
        det = A(1,1)*(A(2,2)*A(3,3) - A(2,3)*A(3,2)) - A(1,2)*(A(2,1)*A(3,3) - A(2,3)*A(3,1)) + A(1,3)*(A(2,1)*A(3,2) - A(2,2)*A(3,1))
        if (abs(det) < 1e-25_wp) then
            invA = 0.0_wp; return
        end if
        invA(1,1) = (A(2,2)*A(3,3) - A(2,3)*A(3,2)) / det; invA(1,2) = (A(1,3)*A(3,2) - A(1,2)*A(3,3)) / det; invA(1,3) = (A(1,2)*A(2,3) - A(1,3)*A(2,2)) / det
        invA(2,1) = (A(2,3)*A(3,1) - A(2,1)*A(3,3)) / det; invA(2,2) = (A(1,1)*A(3,3) - A(1,3)*A(3,1)) / det; invA(2,3) = (A(1,3)*A(2,1) - A(1,1)*A(2,3)) / det
        invA(3,1) = (A(2,1)*A(3,2) - A(2,2)*A(3,1)) / det; invA(3,2) = (A(1,2)*A(3,1) - A(1,1)*A(3,2)) / det; invA(3,3) = (A(1,1)*A(2,2) - A(1,2)*A(2,1)) / det
    end function invert_3x3_r

end module mod_dqd_dp_exacto