WITH ada.Integer_Text_IO; USE ada.Integer_Text_IO;

PROCEDURE euler_2 IS
    limit : CONSTANT natural := 4000000;
    last : natural := 1;
    next : natural := 1;
    sum : integer := 0;
BEGIN
    while next < limit-last LOOP
        next := next + last;
        last := next - last;
        IF next mod 2 = 0 THEN
            sum := sum + next;
        END IF;

    END LOOP;
    put(sum);
END;

