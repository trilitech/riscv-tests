# See LICENSE for license details.

#*****************************************************************************
# bltu.S
#-----------------------------------------------------------------------------
#
# Test bltu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 2, bltu, 0x00000000, 0x00000001 );
  TEST_BR2_OP_TAKEN( 3, bltu, 0xfffffffe, 0xffffffff );
  TEST_BR2_OP_TAKEN( 4, bltu, 0x00000000, 0xffffffff );

  TEST_BR2_OP_NOTTAKEN( 5, bltu, 0x00000001, 0x00000000 );
  TEST_BR2_OP_NOTTAKEN( 6, bltu, 0xffffffff, 0xfffffffe );
  TEST_BR2_OP_NOTTAKEN( 7, bltu, 0xffffffff, 0x00000000 );
  TEST_BR2_OP_NOTTAKEN( 8, bltu, 0x80000000, 0x7fffffff );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 9,  0, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 10, 0, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 11, 0, 2, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 12, 1, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 13, 1, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 14, 2, 0, bltu, 0xf0000000, 0xefffffff );

  TEST_BR2_SRC12_BYPASS( 15, 0, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 16, 0, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 17, 0, 2, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 18, 1, 0, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 19, 1, 1, bltu, 0xf0000000, 0xefffffff );
  TEST_BR2_SRC12_BYPASS( 20, 2, 0, bltu, 0xf0000000, 0xefffffff );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 21, x1, 3, \
    li  x1, 1; \
    bltu x0, x1, 1f; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
    addi x1, x1, 1; \
1:  addi x1, x1, 1; \
    addi x1, x1, 1; \
  )

  #---------------------------
  # Branching tests against x0
  #---------------------------

  TEST_BR2_OP_TAKEN_X0_LHS( 22, bltu,  1 );
  TEST_BR2_OP_TAKEN_X0_LHS( 23, bltu, -1 ); 

  TEST_BR2_OP_NOTTAKEN_X0_LHS( 24, bltu,  0 );
  TEST_BR2_OP_NOTTAKEN_X0_RHS( 25, bltu, -1 );
  TEST_BR2_OP_NOTTAKEN_X0_RHS( 26, bltu,  0 );
  TEST_BR2_OP_NOTTAKEN_X0_RHS( 27, bltu,  1 ); 

  # Test same registers should never branch

  TEST_CASE( 28, x1, 2, \
    li  x1, 1; \
    bltu x0, x0, fail; \
    bltu x1, x1, fail; \
    bltu x2, x2, fail; \
1:  addi x1, x1, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
