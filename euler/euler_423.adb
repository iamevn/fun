WITH Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions, Ada.Long_Long_Integer_Text_IO;
USE Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions, Ada.Long_Long_Integer_Text_IO;

PROCEDURE euler_423 IS
   k : long_long_integer;
   sum : long_long_integer := 0;

   FUNCTION isPrime (n : long_long_integer) RETURN boolean IS
   BEGIN
      FOR i IN 2..long_long_integer(sqrt(float(n))) LOOP
         IF n mod i = 0 THEN
            RETURN false;
         END IF;
      END LOOP;
      RETURN true;
   END isPrime;

   FUNCTION countPrimes(num : long_long_integer) RETURN long_long_integer IS
      numPrimes : long_long_integer := 2;
      n : long_long_integer := 5;
   BEGIN
      WHILE n <= num LOOP
         IF isPrime(n) THEN
            numPrimes := numPrimes + 1;
         END IF;
         n := n + 2;
      END LOOP;
      RETURN numPrimes;
   END;

   FUNCTION findPairs(n : long_long_integer) RETURN long_long_integer IS
      dice : ARRAY(1..n) OF integer RANGE 1..6;
      pairs : long_long_integer RANGE 0..countPrimes(n) := 0;
      c : long_long_integer := 0;
      done : boolean := false;
   BEGIN
      FOR i IN 1..n LOOP
         dice(i) := 1;
      END LOOP;

      WHILE NOT done LOOP --each possible combination
         --count c
         BEGIN
            FOR i IN 1..n-1 LOOP
               IF dice(i) = dice(i+1) THEN
                 pairs := pairs + 1;
               END IF;
            END LOOP;
         EXCEPTION
            WHEN constraint_error =>
               --put_line("hit constraint");
               c := c-1;
         END;
         c := c + 1;

         pairs := 0;

         --increment dice
         FOR i IN REVERSE 1..n LOOP
            IF dice(i) = 6 THEN
               IF i = 1 THEN
                  done := true;
                  EXIT;
               END IF;
               dice(i) := 1;
            ELSE
               dice(i) := dice(i)+1;
               EXIT;
            END IF;
         END LOOP;
      END LOOP;

      RETURN c;
   END;

BEGIN
   get(k);

   FOR s IN 1..k LOOP
      sum := sum + findPairs(k);
   END LOOP;

   put(sum mod 100000007);
END;
      
