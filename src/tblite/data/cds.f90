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

!> @file tblite/data/alpb.f90
!> Provides ALPB/GBSA cds parameters

!> CDS parameters
module tblite_data_cds
   use mctc_env, only : error_type, fatal_error
   use mctc_env, only : wp
   use mctc_io_symbols, only : to_number
   use tblite_solvation_cds, only: cds_input
   use mctc_io, only : structure_type
   use mctc_io_convert, only : aatoau, kcaltoau
   implicit none
   private

   public :: get_cds_param


   type :: cds_parameter
      real(wp) :: rprobe = 0.0_wp
      real(wp) :: gamscale(94) = 0.0_wp
      real(wp) :: tmp(94) = 0.0_wp
   end type cds_parameter

   include 'cds/param_gbsa_acetone.fh'
   include 'cds/param_gbsa_acetonitrile.fh'
   include 'cds/param_gbsa_benzene.fh'
   include 'cds/param_gbsa_ch2cl2.fh'
   include 'cds/param_gbsa_chcl3.fh'
   include 'cds/param_gbsa_cs2.fh'
   include 'cds/param_gbsa_dmso.fh'
   include 'cds/param_gbsa_ether.fh'
   include 'cds/param_gbsa_h2o.fh'
   include 'cds/param_gbsa_methanol.fh'
   include 'cds/param_gbsa_thf.fh'
   include 'cds/param_gbsa_toluene.fh'
   include 'cds/param_gbsa_dmf.fh'
   include 'cds/param_gbsa_nhexan.fh'

   include 'cds/param_alpb_acetone.fh'
   include 'cds/param_alpb_acetonitrile.fh'
   include 'cds/param_alpb_aniline.fh'
   include 'cds/param_alpb_benzaldehyde.fh'
   include 'cds/param_alpb_benzene.fh'
   include 'cds/param_alpb_ch2cl2.fh'
   include 'cds/param_alpb_chcl3.fh'
   include 'cds/param_alpb_cs2.fh'
   include 'cds/param_alpb_dioxane.fh'
   include 'cds/param_alpb_dmf.fh'
   include 'cds/param_alpb_dmso.fh'
   include 'cds/param_alpb_ether.fh'
   include 'cds/param_alpb_ethylacetate.fh'
   include 'cds/param_alpb_furane.fh'
   include 'cds/param_alpb_hexadecane.fh'
   include 'cds/param_alpb_hexane.fh'
   include 'cds/param_alpb_nitromethane.fh'
   include 'cds/param_alpb_octanol.fh'
   include 'cds/param_alpb_phenol.fh'
   include 'cds/param_alpb_thf.fh'
   include 'cds/param_alpb_toluene.fh'
   include 'cds/param_alpb_water.fh'
   include 'cds/param_alpb_woctanol.fh'
   include 'cds/param_alpb_methanol.fh'
   include 'cds/param_alpb_ethanol.fh'

contains


!> Get CDS parameters
subroutine get_cds_param(input, mol, error)
   !> Input of cds
   type(cds_input), intent(inout) :: input
   !> Molecular structure data
   type(structure_type), intent(in) :: mol
   !> Internal parameter type
   type(cds_parameter), allocatable :: param
   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   select case(input%alpb)
   case(.false.)
      if (input%method == 'gfn2') then
         select case(input%solvent)
         case('acetone');      param = gfn2_acetone
         case('acetonitrile'); param = gfn2_acetonitrile
         case('benzene');      param = gfn2_benzene
         case('ch2cl2','dichlormethane'); param = gfn2_ch2cl2
         case('chcl3','chloroform');      param = gfn2_chcl3
         case('cs2');          param = gfn2_cs2
         case('dmso');         param = gfn2_dmso
         case('ether');        param = gfn2_ether
         case('h2o','water');  param = gfn2_h2o
         case('methanol');     param = gfn2_methanol
         case('thf');          param = gfn2_thf
         case('toluene');      param = gfn2_toluene
         case('dmf');          param = gfn2_dmf
         case('nhexan','n-hexan','nhexane','n-hexane','hexane');
            param = gfn2_nhexan
         end select
      else
         select case(input%solvent)
         case('acetone');      param = gfn1_acetone
         case('acetonitrile'); param = gfn1_acetonitrile
         case('benzene');      param = gfn1_benzene
         case('ch2cl2','dichlormethane'); param = gfn1_ch2cl2
         case('chcl3','chloroform');      param = gfn1_chcl3
         case('cs2');          param = gfn1_cs2
         case('dmso');         param = gfn1_dmso
         case('ether');        param = gfn1_ether
         case('h2o','water');  param = gfn1_h2o
         case('methanol');     param = gfn1_methanol
         case('thf');          param = gfn1_thf
         case('toluene');      param = gfn1_toluene
         end select
      end if
   case(.true.)
      if (input%method == 'gfn2') then
         select case(input%solvent)
         case('acetone');      param = gfn2_alpb_acetone
         case('acetonitrile'); param = gfn2_alpb_acetonitrile
         case('aniline');      param = gfn2_alpb_aniline
         case('benzaldehyde');      param = gfn2_alpb_benzaldehyde
         case('benzene');      param = gfn2_alpb_benzene
         case('dioxane');      param = gfn2_alpb_dioxane
         case('ethylacetate');      param = gfn2_alpb_ethylacetate
         case('furane');      param = gfn2_alpb_furane
         case('hexadecane');      param = gfn2_alpb_hexadecane
         case('nitromethane');      param = gfn2_alpb_nitromethane
         case('octanol');      param = gfn2_alpb_octanol
         case('woctanol');      param = gfn2_alpb_woctanol
         case('phenol');      param = gfn2_alpb_phenol 
         case('ch2cl2','dichlormethane'); param = gfn2_alpb_ch2cl2
         case('chcl3','chloroform');      param = gfn2_alpb_chcl3
         case('cs2');          param = gfn2_alpb_cs2
         case('dmso');         param = gfn2_alpb_dmso
         case('ether');        param = gfn2_alpb_ether
         case('h2o','water');  param = gfn2_alpb_water
         case('methanol');     param = gfn2_alpb_methanol 
         case('thf');          param = gfn2_alpb_thf
         case('toluene');      param = gfn2_alpb_toluene
         case('dmf');          param = gfn2_alpb_dmf
         case('ethanol');      param = gfn2_alpb_ethanol
         case('nhexan','n-hexan','nhexane','n-hexane','hexane');
            param = gfn2_alpb_hexane
         end select
      else
         select case(input%solvent)
         case('acetone');      param = gfn1_alpb_acetone
         case('acetonitrile'); param = gfn1_alpb_acetonitrile
         case('aniline');      param = gfn1_alpb_aniline
         case('benzaldehyde');      param = gfn1_alpb_benzaldehyde
         case('benzene');      param = gfn1_alpb_benzene
         case('dioxane');      param = gfn1_alpb_dioxane
         case('ethylacetate');      param = gfn1_alpb_ethylacetate
         case('furane');      param = gfn1_alpb_furane
         case('hexadecane');      param = gfn1_alpb_hexadecane
         case('nitromethane');      param = gfn1_alpb_nitromethane
         case('octanol');      param = gfn1_alpb_octanol
         case('woctanol');      param = gfn1_alpb_woctanol
         case('phenol');      param = gfn1_alpb_phenol 
         case('ch2cl2','dichlormethane'); param = gfn1_alpb_ch2cl2
         case('chcl3','chloroform');      param = gfn1_alpb_chcl3
         case('cs2');          param = gfn1_alpb_cs2
         case('dmso');         param = gfn1_alpb_dmso
         case('ether');        param = gfn1_alpb_ether
         case('h2o','water');  param = gfn1_alpb_water
         case('methanol');     param = gfn1_alpb_methanol
         case('ethanol');      param = gfn1_alpb_ethanol
         case('thf');          param = gfn1_alpb_thf
         case('toluene');      param = gfn1_alpb_toluene
         case('dmf');          param = gfn1_alpb_dmf
         case('nhexan','n-hexan','nhexane','n-hexane','hexane');
            param = gfn1_alpb_hexane
         end select
      end if
   end select

   if (.not.allocated(param)) then
      call fatal_error(error, "Unknown solvent")
   end if
 
   call load_cds_param(input, mol, param)
   return

end subroutine get_cds_param

subroutine load_cds_param(input, mol, param)
   !> Input of cds
   type(cds_input), intent(inout) :: input
   !> Molecular structure data
   type(structure_type), intent(in) :: mol
   !> Internal Parameter type
   type(cds_parameter), intent(in) :: param


   if (.not. allocated(input%tension)) then
      allocate(input%tension(mol%nid))
   end if

   if (.not. allocated(input%hbond)) then
      allocate(input%hbond(mol%nid))
   end if

   !> set probe radius
   input%probe = param%rprobe * aatoau

   !> set tension parameter
   input%tension = param%gamscale(mol%num) * 1.0e-5_wp 

   !> set hbond parameter
   input%hbond =  -kcaltoau * param%tmp(mol%num)**2 

   return

end subroutine load_cds_param

end module tblite_data_cds
