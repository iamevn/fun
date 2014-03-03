WITH ada.Integer_Text_IO;
USE ada.Integer_Text_IO;

PROCEDURE euler_6 IS
   num : integer;
BEGIN
   get(num);
   put(((num**2/2 + num/2)**2)-(num**3/3 + num**2/2 + num/6));
END;