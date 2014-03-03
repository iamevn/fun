WITH Ada.Numerics.Elementary_Functions, Ada.Long_Long_Integer_Text_IO;
USE Ada.Numerics.Elementary_Functions, Ada.Long_Long_Integer_Text_IO;

PROCEDURE euler_10 IS
   num : long_long_integer := 5;
   sum : long_long_integer := 5;

   FUNCTION Is_Prime (n : long_long_integer) RETURN boolean IS
   BEGIN
      FOR i IN 2..long_long_integer(sqrt(float(n))) LOOP
         IF n mod i = 0 THEN
            RETURN false;
         END IF;
      END LOOP;
      RETURN true;
   END Is_Prime;

BEGIN
   WHILE num < 2000000 LOOP
      IF Is_Prime(num) THEN
         sum := sum + num;
      END IF;
      num := num + 2;
   END LOOP;
   put(sum);
END;
