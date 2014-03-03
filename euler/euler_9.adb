WITH Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions, Ada.Text_IO;
USE Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions, Ada.Text_IO;

PROCEDURE euler_9 IS

BEGIN
   for n in 0..1000 loop
      FOR i IN n..(1000) LOOP
         IF float'remainder(sqrt(float(n**2 + i**2)), 1.0) = 0.0 THEN
            IF n+i+integer(sqrt(float(n**2 + i**2))) = 1000 THEN
               put(n+i+integer(sqrt(float(n**2 + i**2))));                put(n*i*integer(sqrt(float(n**2 + i**2)))); new_line;
               put(n); put(i); put(integer(sqrt(float(n**2 + i**2)))); new_line;
            END IF;
         END IF;
      END LOOP;
   END LOOP;
END;

