# See LICENSE for license details.

#*****************************************************************************
# bgeu.S
#-----------------------------------------------------------------------------
#
# Test bgeu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  TEST_BR2_OP_TAKEN( 2, bgeu, 0x00000000, 0x00000000 );
  TEST_BR2_OP_TAKEN( 3, bgeu, 0x00000001, 0x00000001 );
  TEST_BR2_OP_TAKEN( 4, bgeu, 0xffffffff, 0xffffffff );
  TEST_BR2_OP_TAKEN( 5, bgeu, 0x00000001, 0x00000000 );
  TEST_BR2_OP_TAKEN( 6, bgeu, 0xffffffff, 0xfffffffe );
  TEST_BR2_OP_TAKEN( 7, bgeu, 0xffffffff, 0x00000000 );

  TEST_BR2_OP_NOTTAKEN(  8, bgeu, 0x00000000, 0x00000001 );
  TEST_BR2_OP_NOTTAKEN(  9, bgeu, 0xfffffffe, 0xffffffff );
  TEST_BR2_OP_NOTTAKEN( 10, bgeu, 0x00000000, 0xffffffff );
  TEST_BR2_OP_NOTTAKEN( 11, bgeu, 0x7fffffff, 0x80000000 );

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  TEST_BR2_SRC12_BYPASS( 12, 0, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 13, 0, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 14, 0, 2, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 15, 1, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 16, 1, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 17, 2, 0, bgeu, 0xefffffff, 0xf0000000 );

  TEST_BR2_SRC12_BYPASS( 18, 0, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 19, 0, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 20, 0, 2, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 21, 1, 0, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 22, 1, 1, bgeu, 0xefffffff, 0xf0000000 );
  TEST_BR2_SRC12_BYPASS( 23, 2, 0, bgeu, 0xefffffff, 0xf0000000 );

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  TEST_CASE( 24, x1, 3, \
    li  x1, 1; \
    bgeu x1, x0, 1f; \
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

  TEST_BR2_OP_TAKEN_X0_LHS( 25, bgeu,  0 );
  TEST_BR2_OP_TAKEN_X0_RHS( 26, bgeu,  0 );
  TEST_BR2_OP_TAKEN_X0_RHS( 27, bgeu,  1 );
  TEST_BR2_OP_TAKEN_X0_RHS( 28, bgeu, -1 ); 

  TEST_BR2_OP_NOTTAKEN_X0_LHS( 29, bgeu, -1 );
  TEST_BR2_OP_NOTTAKEN_X0_LHS( 30, bgeu,  1 ); 

  # Test same registers should always branch

  TEST_CASE( 31, x1, 1, \
    li  x1, 1; \
    bgeu x0, x0, 2f; \
    addi x1, x1, 1; \
1:  bgeu x1, x1, 3f; \
2:  bgeu x2, x2, 1b; \
    addi x1, x1, 1; \
3:
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
