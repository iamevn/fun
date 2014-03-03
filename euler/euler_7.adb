WITH Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;
USE Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;

PROCEDURE euler_7 IS
   num : integer := 1;
   numPrimes : integer := 0;

   FUNCTION isPrime (n : integer) RETURN boolean IS
   BEGIN
      FOR i IN 2..integer(sqrt(float(n))) LOOP
         IF n mod i = 0 THEN
            RETURN false;
         END IF;
      END LOOP;
      RETURN true;
   END isPrime;
BEGIN
   LOOP
      IF isPrime(num) THEN
         numPrimes := numPrimes + 1;
         IF numPrimes = 10001 THEN
            EXIT;
         END IF;
      END IF;
      num := num + 2;
   END LOOP;
   put(num);
END;
