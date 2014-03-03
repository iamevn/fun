WITH ada.Integer_Text_IO; USE ada.Integer_Text_IO;

PROCEDURE euler_1 IS
    limit : CONSTANT natural := 1000;
    sum : integer := 0;
BEGIN
    FOR i IN 1..limit-1 LOOP
        IF (i mod 3 = 0) OR (i mod 5 = 0) THEN
            sum := sum + i;
        END IF;
    END LOOP;
    put(sum);
END;

