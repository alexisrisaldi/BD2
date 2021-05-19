


/*CURSORES*/

SELECT * FROM B_LOCALIDAD;

DECLARE
	CURSOR LOCALI IS
		SELECT * FROM B_LOCALIDAD;
	
	CURSOR C_CLIENTES (ID_LOCAL NUMBER) IS
		SELECT bp.NOMBRE, bp.APELLIDO, SUM(bv.MONTO_TOTAL) 
			FROM B_PERSONAS bp JOIN B_VENTAS bv
			ON bv.ID_CLIENTE = bp.ID
			JOIN B_LOCALIDAD bl
			ON bl.ID = bp.ID_LOCALIDAD
			WHERE bp.ES_CLIENTE = 'S'
			AND bl.ID = ID_LOCAL
			GROUP BY bp.NOMBRE, bp.APELLIDO;

BEGIN
	FOR A IN LOCALI LOOP	/*NO HACER OPEN NI FETCH USANDO FOR LOOP*/
	DBMS_OUTPUT.PUT_LINE('LOCALIDAD:'||A.NOMBRE);
		FOR R_CLI IN C_CLIENTES LOOP
			DBMS_OUTPUT.PUT_LINE('CLIENTE: '||R_CLI.NOMBRE||' '||' VENTAS: '||R_CLI.TOTAL);
		END LOOP;
	END LOOP;
END;


/*OBJETOS LARGE*/
Una tabla puede contener múltiples columnas LOB, pero
solamente una columna de tipo LONG.

CLOB: Al crear una tabla con un campo CLOB este se debe inicializar con un
Locator vacío, no dejarlo NULL. 
• Para realizar esto lo hacemos mediante la función EMPTY_CLOB().




CREATE TABLE TABLA_CLOB
(ID NUMBER,
DOCUMENTO CLOB DEFAULT EMPTY_CLOB());
//se creó una tabla y documento es tipo clob



Para insertar un valor sobre un campo CLOB lo hacemos tan similar
como si fuera un campo VARCHAR2, ejemplo:
INSERT INTO TABLA_CLOB2 VALUES(2 , 'Esto es un texto' );

CREATE TABLE TABLA_CLOB2
( ID NUMBER,
DOCUMENTO CLOB DEFAULT EMPTY_CLOB())
LOB(DOCUMENTO) STORE AS BASICFILE CTAB (TABLESPACE BASETP);

DBMS_LOB
Este paquete sirve para manipular este tipo de objetos,
APPEND: Añade los contenidos de un objeto LOB de origen al final de un objeto LOB de destino

COMPARE Determina si 2 objetos LOB son iguales

COPY Copia datos desde una posición dada en el objeto LOB de origen a una posición dada
en el objeto LOB de destino

ERASE Borra todo el objeto LOB o una parte del mismo a partir de una posición especificada
GETLENGTH Devuelve la longitud de un objeto LOB

READ Devuelve los datos de un objeto LOB a partir de una posición

WRITE Escribe datos en un objeto LOB a partir de la posición dada

TRIM Borra datos del final de un objeto LOB

SUBSTR Devuelve una parte de los datos del objeto LOB a partir de la posición dada

LOADFROMFILE Lee un determinado número de bytes de una variable definida como BFILE en un
objeto de tipo BLOB

SELECT DBMS_LOB.SUBSTR(DOCUMENTO,5,12 )
FROM TABLA_CLOB2;
-texto

SELECT DBMS_LOB.INSTR(DOCUMENTO,'e',1,2)
FROM TABLA_CLOB;
- cuenta el nro de la posision
13, este es un texto:



DECLARE
v_clob CLOB;
BEGIN
	SELECT documento INTO v_clob
	FROM TABLA_CLOB2
	WHERE id=2 FOR UPDATE;
	DBMS_LOB.WRITEAPPEND(v_clob, 9, ' ejemplo ' ) ;
	DBMS_OUTPUT.PUT_LINE(v_clob) ;
	COMMIT;
END;
- este es un texto ejemplo ejemplo
HAY QUE CREAR PREVIAMENTE LA CARPETA

GRANT WRITE, READ ON DIRECTORY MIS_BLOBS TO BASEDATOS2;


