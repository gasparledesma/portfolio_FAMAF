module funciones
   use isoprec
   implicit none

   ! Parámetros del sistema
   real(kind=wp), parameter :: epsilon0 = 0.0_wp   ! energía central
   real(kind=wp), parameter :: V        = 1.0_wp   ! acoplamiento

contains

   !---------------------------------------------------------------
   function sigma(t) result(s)
      implicit none
      real(kind=wp), intent(in) :: t
      real(kind=wp)             :: s
      s = (t - epsilon0)/2.0_wp + sqrt(((t - epsilon0)/2.0_wp)**2 - V**2)
   end function sigma
   !---------------------------------------------------------------

   recursive function sigma_iter(t,n) result(sit)
      implicit none
      real(kind=wp), intent(in) :: t
      integer, intent(in)       :: n
      real(kind=wp)             :: sit

      if (n <= 0) then
         sit = 0.0_wp
      else
         sit = V**2 / (t - epsilon0 - sit(t, n-1))
      end if
   end function sigma_iter
   !---------------------------------------------------------------

   function Green(t,n) result(G)
      implicit none
      real(kind=wp), intent(in) :: t
      integer, intent(in)       :: n
      complex(kind=wp)          :: G
      ! En general Green es complejo: añadimos un i*eta para regularizar
      real(kind=wp), parameter  :: eta = 1.0e-6_wp

      G = 1.0_wp / ( t - epsilon0 - sigma_iter(t,n) - sigma(t) )
   end function Green
   !---------------------------------------------------------------

end module funciones
