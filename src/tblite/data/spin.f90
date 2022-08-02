! This file is part of tblite.
! SPDX-Identifier: LGPL-3.0-or-later
!
! tblite is free software: you can redistribute it and/or modify it under
! the terms of the GNU Lesser General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! tblite is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public License
! along with tblite.  If not, see <https://www.gnu.org/licenses/>.

!> @file tblite/data/spin.f90
!> Provides spin constants for all elements

!> Spin constants
module tblite_data_spin
   use mctc_env, only : wp
   use mctc_io_symbols, only : to_number
   implicit none
   private

   public :: get_spin_constant, read_spin_constants

   !> Get spin constant for species
   interface get_spin_constant
      module procedure :: get_spin_constant_symbol
      module procedure :: get_spin_constant_number
   end interface get_spin_constant

   integer, parameter :: lidx(0:2, 0:2) = reshape(& ! ss sp sd  sp pp pd  sd pd dd
      & [1, 2, 4,  2, 3, 5,  4, 5, 6], shape(lidx))

   real(wp) :: spin_constants(6, 86) = reshape([&  ! ss, sp, pp, sd, pd, dd
      -0.1242700_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0865325_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0267250_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0229275_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0276700_wp,-0.0223200_wp,-0.0200850_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0318975_wp,-0.0258375_wp,-0.0233450_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0355100_wp,-0.0286600_wp,-0.0259800_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0364675_wp,-0.0302525_wp,-0.0280275_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0371600_wp,-0.0313825_wp,-0.0299675_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0383500_wp,-0.0326350_wp,-0.0316650_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0201500_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0165650_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0184750_wp,-0.0142500_wp,-0.0148500_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0203150_wp,-0.0160375_wp,-0.0159200_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0217325_wp,-0.0175750_wp,-0.0170450_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0218975_wp,-.01759875_wp,-0.0161575_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0219625_wp,-0.0178575_wp,-0.0161975_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0222100_wp,-0.0183425_wp,-0.0165900_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0143375_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0118125_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0127575_wp, 0.0000000_wp, 0.0000000_wp,-0.0048125_wp, 0.0000000_wp,-0.0123850_wp, &
      -0.0134250_wp, 0.0000000_wp, 0.0000000_wp,-.00443875_wp, 0.0000000_wp,-0.0135425_wp, &
      -0.0139625_wp, 0.0000000_wp, 0.0000000_wp,-0.0041950_wp, 0.0000000_wp,-0.0143600_wp, &
      -0.0144225_wp, 0.0000000_wp, 0.0000000_wp,-.00403875_wp, 0.0000000_wp,-0.0149975_wp, &
      -0.0148575_wp, 0.0000000_wp, 0.0000000_wp,-.00393375_wp, 0.0000000_wp,-0.0155225_wp, &
      -0.0154000_wp, 0.0000000_wp, 0.0000000_wp,-0.0036000_wp, 0.0000000_wp,-0.0167900_wp, &
      -0.0158000_wp, 0.0000000_wp, 0.0000000_wp,-.00329125_wp, 0.0000000_wp,-0.0176250_wp, &
      -0.0161600_wp, 0.0000000_wp, 0.0000000_wp,-0.0030625_wp, 0.0000000_wp,-0.0182550_wp, &
      -0.0165600_wp, 0.0000000_wp, 0.0000000_wp,-0.0028575_wp, 0.0000000_wp,-0.0188000_wp, &
      -0.0168400_wp, 0.0000000_wp, 0.0000000_wp,-0.0027650_wp, 0.0000000_wp,-0.0192600_wp, &
      -0.0173125_wp,-.01298375_wp,-0.0143450_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0178000_wp,-.01384625_wp,-0.0146325_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0182150_wp,-.01452625_wp,-0.0150000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0183100_wp,-0.0145500_wp,-0.0141600_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0181675_wp,-.01447875_wp,-0.0138100_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0181275_wp,-0.0146025_wp,-0.0137700_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0138300_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0106500_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0114075_wp, 0.0000000_wp, 0.0000000_wp,-0.0067850_wp, 0.0000000_wp,-0.0096650_wp, &
      -0.0119400_wp, 0.0000000_wp, 0.0000000_wp,-0.0061900_wp, 0.0000000_wp,-0.0105475_wp, &
      -0.0123375_wp, 0.0000000_wp, 0.0000000_wp,-.00573125_wp, 0.0000000_wp,-0.0111575_wp, &
      -0.0126525_wp, 0.0000000_wp, 0.0000000_wp,-0.0053500_wp, 0.0000000_wp,-0.0116725_wp, &
      -0.0129175_wp, 0.0000000_wp, 0.0000000_wp,-0.0050150_wp, 0.0000000_wp,-0.0121725_wp, &
      -0.0132225_wp, 0.0000000_wp, 0.0000000_wp,-0.0047550_wp, 0.0000000_wp,-0.0127400_wp, &
      -0.0133275_wp, 0.0000000_wp, 0.0000000_wp,-.00437875_wp, 0.0000000_wp,-0.0128675_wp, &
      -0.0134675_wp, 0.0000000_wp, 0.0000000_wp,-0.0041000_wp, 0.0000000_wp,-0.0130250_wp, &
      -0.0137050_wp, 0.0000000_wp, 0.0000000_wp,-.00386375_wp, 0.0000000_wp,-0.0131975_wp, &
      -0.0138850_wp, 0.0000000_wp, 0.0000000_wp,-0.0036875_wp, 0.0000000_wp,-0.0134000_wp, &
      -0.0141425_wp,-0.0106275_wp,-0.0125775_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0142975_wp,-.01102625_wp,-0.0124750_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0144700_wp,-.01136875_wp,-0.0124725_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0147150_wp,-0.0115250_wp,-0.0118925_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0146625_wp,-0.0114325_wp,-0.0115625_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0146350_wp,-.01144625_wp,-0.0114150_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0121450_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0092875_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0099275_wp, 0.0000000_wp, 0.0000000_wp,-.00592875_wp, 0.0000000_wp,-0.0089625_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0100000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0122850_wp, 0.0000000_wp, 0.0000000_wp,-0.0077550_wp, 0.0000000_wp,-0.0102550_wp, &
      -0.0125250_wp, 0.0000000_wp, 0.0000000_wp,-0.0073250_wp, 0.0000000_wp,-0.0107500_wp, &
      -0.0127175_wp, 0.0000000_wp, 0.0000000_wp,-0.0069475_wp, 0.0000000_wp,-0.0111075_wp, &
      -0.0128725_wp, 0.0000000_wp, 0.0000000_wp,-.00659375_wp, 0.0000000_wp,-0.0114225_wp, &
      -0.0129900_wp, 0.0000000_wp, 0.0000000_wp,-0.0062725_wp, 0.0000000_wp,-0.0118475_wp, &
      -0.0129200_wp, 0.0000000_wp, 0.0000000_wp,-0.0058575_wp, 0.0000000_wp,-0.0118550_wp, &
      -0.0128575_wp, 0.0000000_wp, 0.0000000_wp,-.00551125_wp, 0.0000000_wp,-0.0118000_wp, &
      -0.0129100_wp, 0.0000000_wp, 0.0000000_wp,-0.0052475_wp, 0.0000000_wp,-0.0117925_wp, &
      -0.0129250_wp, 0.0000000_wp, 0.0000000_wp,-.00506125_wp, 0.0000000_wp,-0.0118400_wp, &
      -0.0132850_wp,-0.0091625_wp,-0.0124800_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0134725_wp,-0.0094275_wp,-0.0121925_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0135975_wp,-.00963125_wp,-0.0120050_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0138300_wp,-.00984125_wp,-0.0110425_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0138425_wp,-.00976125_wp,-0.0107950_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp, &
      -0.0138725_wp,-0.0097450_wp,-0.0106200_wp, 0.0000000_wp, 0.0000000_wp, 0.0000000_wp],&
      shape(spin_constants))

contains


!> Get spin constant for species with a given symbol
elemental function get_spin_constant_symbol(jang, iang, symbol) result(wll)

   !> Angular momentum of shells
   integer, intent(in) :: jang, iang

   !> Element symbol
   character(len=*), intent(in) :: symbol

   !> Spin constant
   real(wp) :: wll

   wll = get_spin_constant(jang, iang, to_number(symbol))

end function get_spin_constant_symbol


!> Get spin constant for species with a given atomic number
elemental function get_spin_constant_number(jang, iang, number) result(wll)

   !> Angular momentum of shells
   integer, intent(in) :: jang, iang

   !> Atomic number
   integer, intent(in) :: number

   !> Spin constant
   real(wp) :: wll

   if (number > 0 .and. number <= size(spin_constants, dim=2)) then
      wll = spin_constants(lidx(jang, iang), number)
   else
      wll = -1.0_wp
   end if

end function get_spin_constant_number

!> Read spin constants from external file
subroutine read_spin_constants(filename)

   !> Name of the inputfile
   character(len=*),intent(in) :: filename
   integer :: input 
   integer :: i

   open(newunit=input, file=filename, status='old')
   do i=1,86
     read(input, *) spin_constants(1,i), spin_constants(2,i), spin_constants(3,i), spin_constants(4,i), & 
        & spin_constants(5,i), spin_constants(6,i)
   end do
    

   close(input)

   !> Read from spin_param.txt and modify spin_constants accordingly 

end subroutine read_spin_constants




end module tblite_data_spin
