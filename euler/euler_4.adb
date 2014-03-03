WITH Ada.Integer_Text_IO, Ada.Text_IO, Ada.Numerics.Elementary_Functions;
USE Ada.Integer_Text_IO, Ada.Text_IO, Ada.Numerics.Elementary_Functions;

-- find the largest palindrome made from product of two 3-digit numbers
PROCEDURE euler_4 IS

   FUNCTION Make_Reverse(input : string) RETURN string IS
      output : string(1..7);
   BEGIN
      FOR i IN input'range LOOP
         output(input'last - i + 1) := input(i);
      END LOOP;
      RETURN output;
   END;

   FUNCTION Better_Reverse(input : integer) RETURN integer IS
      reversed : integer := 0;
      t : integer;
   BEGIN
      t:=input;
      WHILE t > 0 LOOP
         reversed := reversed * 10;
         reversed := reversed + (t mod 10);
         t := t / 10;
      END LOOP;
      RETURN reversed;
   END;

   FUNCTION Is_Palindrome(num : integer) RETURN boolean IS
   BEGIN
      --IF num = integer'value(Make_Reverse(integer'image(num))) THEN
      IF num = Better_Reverse(num) THEN
         RETURN true;
      ELSE
         RETURN false;
      END IF;
   END;

   FUNCTION Three_Digit_Factors(n : integer) RETURN boolean IS
   BEGIN
      FOR k IN 100..999 LOOP --only want factors that are 3 digits
         IF n mod k = 0 THEN
            IF (n / k) / 100 >= 1 AND (n / k) / 1000 = 0 THEN --paired factor is exactly 3 digits
               RETURN true;
            END IF;
         END IF;
      END LOOP;
      RETURN false;
   END;

BEGIN
   FOR i IN REVERSE 10000..998001 LOOP --from 100*100 to 999*999 in reverse
      IF Is_Palindrome(i) THEN
         IF Three_Digit_Factors(i) THEN
            put(i);
            EXIT;
         END IF;
      END IF;
   END LOOP;
END;
