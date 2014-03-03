WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

PROCEDURE euler_11 IS
   TYPE EulerArray IS ARRAY(1..400) OF integer;
   numArray : EulerArray;
   maxProduct : integer := 0;

   FUNCTION Product_A(index : integer) RETURN integer IS
   BEGIN
      IF (index + 2) mod 20 = 0 OR (index + 1) mod 20 = 0 OR index mod 20 = 0 THEN
         RETURN 0;
      END IF;

      RETURN numArray(index) * numArray(index + 1) * numArray(index + 2) * numArray(index + 3);
   END;

   FUNCTION Product_B(index : integer) RETURN integer IS
   BEGIN
      IF index > 340 THEN
         RETURN 0;
      END IF;

      RETURN numArray(index) * numArray(index + 20) * numArray(index + 40) * numArray(index + 60);
   END;

   FUNCTION Product_C(index : integer) RETURN integer IS
   BEGIN
      IF ((index + 2) mod 20 = 0 OR (index + 1) mod 20 = 0 OR index mod 20 = 0) OR index > 340 THEN
         RETURN 0;
      END IF;

      RETURN numArray(index) * numArray(index + 21) * numArray(index + 42) * numArray(index + 63);
   END;

   FUNCTION Product_D(index : integer) RETURN integer IS
   BEGIN
      IF ((index + 2) mod 20 = 0 OR (index + 1) mod 20 = 0 OR index mod 20 = 0) OR index < 61 THEN
         RETURN 0;
      END IF;

      RETURN numArray(index) * numArray(index-19) * numArray(index - 38) * numArray(index - 57);
   END;

   PROCEDURE Fill_Array(a : OUT EulerArray) IS
   BEGIN
      FOR i IN 1..400 LOOP
         get(a(i));
      END LOOP;
   END;

BEGIN
   Fill_Array(numArray);

   FOR i IN 1..400 LOOP
      IF maxProduct < Product_A(i) THEN
         maxProduct := Product_A(i);
      END IF;

      IF maxProduct < Product_B(i) THEN
         maxProduct := Product_B(i);
      END IF;

      IF maxProduct < Product_C(i) THEN
         maxProduct := Product_C(i);
      END IF;

      IF maxProduct < Product_D(i) THEN
         maxProduct := Product_D(i);
      END IF;
   END LOOP;
   put(maxProduct);
END;
