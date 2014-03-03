WITH Ada.Long_Long_Integer_Text_IO, Ada.Numerics.Elementary_Functions;
USE Ada.Long_Long_Integer_Text_IO, Ada.Numerics.Elementary_Functions;

PROCEDURE euler_3 IS
   num : CONSTANT long_long_integer := 600851475143;

   FUNCTION isPrime (n : long_long_integer) RETURN boolean IS
   BEGIN
      FOR i IN 2..long_long_integer(sqrt(float(n))) LOOP
         IF n mod i = 0 THEN
            RETURN false;
         END IF;
      END LOOP;
      RETURN true;
   END isPrime;

BEGIN
   FOR d IN REVERSE 1..long_long_integer(sqrt(float(num))) LOOP
      IF (num mod d = 0) THEN
         IF isPrime(d) THEN
            put(d);
            EXIT;
         END IF;
      END IF;
   END LOOP;
END;