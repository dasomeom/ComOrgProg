cmake_minimum_required(VERSION 3.12)
project(hw08)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)
include_directories(suites)

add_executable(hw08
        suites/fakemalloc.h
        suites/list_suite.c
        suites/suites.h
        suites/test_utils.h
        hw08.pdf
        list.c
        list.h
        list.o
        Makefile
        person.c
        person.h
        person.o
        tests
        tests.c
        tests.o
        verify.sh)
