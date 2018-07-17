`ifdef TEST_BENCH
    real pi = 3.1415926;
`elsif HIGH_ACCURACY
    reg[15:0] pi = 31415;
`else
    reg[7:0] pi = 31;
`fi
