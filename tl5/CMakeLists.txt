cmake_minimum_required(VERSION 3.12)
project(tl05)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)
include_directories(suites)

add_executable(tl05
        suites/bst_suite.c
        suites/fakemalloc.h
        suites/suites.h
        suites/test_utils.h
        suites/test_utils.o
        binary_search_tree.c
        binary_search_tree.h
        Makefile
        tests.c
        Timed_Lab_5_Fall_2018.pdf
        verify.sh)
