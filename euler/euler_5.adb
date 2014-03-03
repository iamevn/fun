WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

PROCEDURE euler_5 IS
   num : positive := 20;

   FUNCTION Is_Divisible (n : integer) RETURN boolean IS
   BEGIN
      FOR i IN REVERSE 1..20 LOOP
         IF NOT (n mod i = 0) THEN
            RETURN false;
         END IF;
      END LOOP;
      RETURN true;
   END;
BEGIN
   LOOP
      IF Is_Divisible(num) THEN
         put(num);
         EXIT;
      END IF;
      num := num+20;
   END LOOP;
END;