.global _start
.text
_start:
        bl openfb
        cmp x0,#0
        b.lt .exit
        mov x8, x0
        bl clear

.display_B:
        #get the color yellow and store in x6
        mov x0, #10
        mov x1, #30
        mov x2, #30
        bl getColor
        mov x6, x0

        mov x4, #1
        mov x5, #6
        mov x12, #6
        bl .display_col

        mov x4, #1
        mov x5, #5
        mov x12, #6
        bl .display_col


        mov x2, x6
        mov x0, #1
        mov x1, #4
        bl setPixel

        mov x2, x6
        mov x0, #3
        mov x1, #4
        bl setPixel

        mov x2, x6
        mov x0, #6
        mov x1, #4
        bl setPixel

        mov x2, x6
        mov x0, #1
        mov x1, #3
        bl setPixel

        mov x2, x6
        mov x0, #3
        mov x1, #3
        bl setPixel

        mov x2, x6
        mov x0, #6
        mov x1, #3
        bl setPixel

        mov x2, x6
        mov x0, #2
        mov x1, #2
        bl setPixel

        mov x4, #4
        mov x5, #2
        mov x12, #6
        bl .display_col


        mov x4, #4
        mov x5, #1
        mov x12, #6
        bl .display_col

.display_Z:
        bl pause
        bl clear
        #get the color purple and store in x6
        mov x0, #30
        mov x1, #0
        mov x2, #30
        bl getColor
        mov x6, x0

        mov x4, #1
        mov x5, #6
        mov x12, #1
        bl .display_row


        mov x2, x6
        mov x0, #2
        mov x1, #2
        bl setPixel

        mov x2, x6
        mov x0, #3
        mov x1, #3
        bl setPixel

        mov x2, x6
        mov x0, #4
        mov x1, #4
        bl setPixel

        mov x2, x6
        mov x0, #5
        mov x1, #5
        bl setPixel


        mov x4, #6
        mov x5, #6
        mov x12, #1
        bl .display_row
.exit:
        bl pause
        bl clear
        bl closefb
        mov x8, #93
        svc #0
pause:
        #x13 is roughly pause seconds times 5
        mov x13, #15
        .timing_loop:
        mov x14, #10000
        .timing_outer_loop:
        mov x9, #10000
        .timing_inner_loop:
                sub x9, x9, #1
                cbnz x9, .timing_inner_loop
                sub x14, x14, #1
                cbnz x14, .timing_outer_loop
                sub x13, x13, #1
                cbnz x13, .timing_loop
                ret

clear:
        mov x0, #0
        mov x1, #0
        mov x2, #0
        mov x15, x30
        bl getColor
        mov x30, x15
        mov x2, x0

        #iteration variable
        mov x10, #7
        .outer_loop:
                cmp x10, #0
                b.lt .outer_exit
                mov x11, #7
        .inner_loop:
                cmp x11, #0
                b.lt .inner_exit
                mov x0, x10
                mov x1, x11
                mov x15, x30
                bl setPixel
                mov x30, x15
                sub x11, x11, #1
                b .inner_loop
        .inner_exit:
                sub x10, x10, #1
                b .outer_loop

.display_col:
        #displays collumn with color stored in x6 from the value in x4 until the value in x12 inclusive
        mov x2, x6
        mov x0, x4
        mov x1, x5
        cmp x0, x12
        b.gt .outer_exit
        mov x8, x30
        bl setPixel
        mov x30, x8
        add x4, x4, #1
        b .display_col
.display_row:
        #displays row with color stored in x6 from the value in x5 until the value in x12 inclusive
        mov x2, x6
        mov x0, x4
        mov x1, x5
        cmp x1, x12
        b.lt .outer_exit
        mov x8, x30
        bl setPixel
        mov x30, x8
        sub x5, x5, #1
        b .display_row

.outer_exit:
        ret