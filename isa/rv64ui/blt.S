# See LICENSE for license details.

#*****************************************************************************
# blt.S
#-----------------------------------------------------------------------------
#
# Test blt instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 2, blt,  0,  1 );
  TEST_BR2_OP_TAKEN( 3, blt, -1,  1 );
  TEST_BR2_OP_TAKEN( 4, blt, -2, -1 );

  TEST_BR2_OP_NOTTAKEN( 5, blt,  1,  0 );
  TEST_BR2_OP_NOTTAKEN( 6, blt,  1, -1 );
  TEST_BR2_OP_NOTTAKEN( 7, blt, -1, -2 );
  TEST_BR2_OP_NOTTAKEN( 8, blt,  1, -2 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 9,  0, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 10, 0, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 11, 0, 2, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 12, 1, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 13, 1, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 14, 2, 0, blt, 0, -1 );

  TEST_BR2_SRC12_BYPASS( 15, 0, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 16, 0, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 17, 0, 2, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 18, 1, 0, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 19, 1, 1, blt, 0, -1 );
  TEST_BR2_SRC12_BYPASS( 20, 2, 0, blt, 0, -1 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 21, x1, 3, \
    li  x1, 1; \
    blt x0, x1, 1f; \
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

  TEST_BR2_OP_TAKEN_X0_LHS( 22, blt, 1 );
  TEST_BR2_OP_TAKEN_X0_RHS( 23, blt, -1 );

  TEST_BR2_OP_NOTTAKEN_X0_LHS ( 24, blt, -1 ); 
  TEST_BR2_OP_NOTTAKEN_X0_LHS( 25, blt, 0 );
  TEST_BR2_OP_NOTTAKEN_X0_RHS( 26, blt, 0 );
  TEST_BR2_OP_NOTTAKEN_X0_RHS ( 27, blt, 1 ); 

  # Test same registers should never branch

  TEST_CASE( 28, x1, 2, \
    li  x1, 1; \
    blt x0, x0, fail; \
    blt x1, x1, fail; \
    blt x2, x2, fail; \
1:  addi x1, x1, 1; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
