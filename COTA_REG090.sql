--/*Registro 090

DECLARE @CODEMP VARCHAR (6), @FCHEMI DATE, @FCHENT DATE, @FCHPAG DATE, @CODTRA VARCHAR (12), @ENVCHE VARCHAR (1), @ENVTRA VARCHAR (1), @NROLOT VARCHAR (3), @NOMARCH VARCHAR(15), @PERFIN VARCHAR(1)
SET @NROLOT = '72'
SET @CODTRA = 'USR_PF'
SET @FCHEMI = '2018-09-20'
SET @FCHENT = '2018-09-20'
SET @FCHPAG = '2018-09-20'
SET @ENVCHE = 'N'
SET @ENVTRA = 'S'
SET @CODEMP = 'COTALT'
SET @NOMARCH = 'PALN'
SET @PERFIN ='N'
--*/

SELECT 
'0306' FLD001,
'090' FLD002,
'CUIT' FLD003,
 Replace((SELECT VALUE_STRING FROM CWPARAMETERS WHERE PARAMNAME = 'GR_NRCUIT' AND COMPANYNAME = @CODEMP),'-','') FLD004,
'@@@@@@' FLD005,
RIGHT(SPACE(15)+'PAPFRA.txt',15) FLD006,
CONVERT(VARCHAR,CJRMVI_NROFOR) FLD007,
'1' FLD008,
PVMPRH.PVMPRH_TIPDOC FLD009,
ISNULL(PVMPRH.PVMPRH_NRODOC,SPACE(11)) FLD010,
RIGHT(SPACE (40)+ RTRIM(LTRIM(PVMPRH.PVMPRH_NOMBRE)),40) FLD011, /*PRO-DENOMINA: Denominación del proveedor*/
SPACE(2) FLD012, 
@PERFIN FLD013, /*FECHA-PAGO*/ 
REPLICATE(0,2) FLD014, /*PRO-CUS-TIP se utilizaba para bonos*/
REPLICATE(0,3) FLD015, /*PRO-CUS-SUC se utilizaba para bonos*/
REPLICATE(0,10) FLD016, /*PRO-CUS-NRO se utilizaba para bonos*/
CJTCTA.CJTCTA_CLABCO FLD017, /*EQUIV 01 para CC, 02 para CA*/ /* COMPLETAR  EQUIVALENCIA!!! */
RIGHT(REPLICATE('0',11)+ISNULL(CASE WHEN PVMPRH_TIPDOC = 'INBR' OR PVMPRH_TIPDOC = 'IBRL' THEN PVMPRH_NRODOC
	 WHEN PVMPRH_TIPDO1 = 'INBR' OR PVMPRH_TIPDO1 = 'IBRL' THEN PVMPRH_NRODO1	
	 WHEN PVMPRH_TIPDO2 = 'INBR' OR PVMPRH_TIPDO2 = 'IBRL' THEN PVMPRH_NRODO2	
	 WHEN PVMPRH_TIPDO3 = 'INBR' OR PVMPRH_TIPDO3 = 'IBRL' THEN PVMPRH_NRODO3	
	 END,SPACE(11)),11) FLD018,
	 
RIGHT(PVMPRH_DIRECC,24) FLD019, /*CALLE*/
RIGHT('00000'+ISNULL(PVMPRH_NUMERO,'     '),5) FLD020,
RIGHT('000'+ISNULL(PVMPRH_DEPTOS,'   '),3) FLD021,
RIGHT('00'+ISNULL(PVMPRH_DPPISO,'  '),2) FLD022,
SPACE(28) FLD023,
RIGHT(PVMPRH_CODPOS,5) FLD24,
PVMPRH.PVMPRH_JURISD  FLD025,
'080' FLD026, 
RIGHT(SPACE(40)+RTRIM(LTRIM(PVMPRH_DIREML)),40) FLD027,
SPACE(24) FLD028,
SPACE(5) FLD029,
SPACE(3) FLD030,
SPACE(2) FLD031,
SPACE(28) FLD032,
SPACE(5) FLD033,
SPACE(2) FLD034,
SPACE(3) FLD035,
SPACE(2) FLD036,
SPACE(4) FLD037,
SPACE(4) FLD038,
SPACE(5) FLD039,
SPACE(18) FLD040,
SPACE(2) FLD041,
SPACE(4) FLD042,
SPACE(4) FLD043,
SPACE(5) FLD044,
SPACE(18) FLD045,
SPACE(25) FLD046,
SPACE(3) FLD047,
SPACE(8) FLD048,
SPACE(25) FLD049,
SPACE(3) FLD050,
SPACE(8) FLD051,
SPACE(25) FLD052,
SPACE(3) FLD053,
SPACE(8) FLD054,
SPACE(100) FLD055,
RIGHT('0000000'+CJRMVI_NROFOR,8) FLD056,
SPACE(217) FLD057,

(CJRMVI.CJRMVI_CODEMP + CJRMVI_MODFOR + CJRMVI_CODFOR + CONVERT(VARCHAR,CJRMVI_NROFOR))+CONVERT(VARCHAR,1) FLD080 /*Orden de Registro*/

FROM
CJRMVI INNER JOIN PVMPRH ON
CJRMVI_NROCPV = PVMPRH_NROCTA
INNER JOIN GRCCOH ON 
GRCCOH_CODCPT = CJRMVI_CODCPT AND
GRCCOH_TIPCPT = CJRMVI_TIPCPT AND
GRCCOH_MODCPT = CJRMVI_MODCPT
INNER JOIN CJTCTA ON
CJRMVI_CTACTE = CJTCTA_CTACTE

WHERE
GRCCOH_PIDCHE = 
(CASE WHEN (@ENVCHE = 'S' AND @ENVTRA = 'S') THEN
GRCCOH_PIDCHE
ELSE
	(CASE WHEN (@ENVCHE = 'S' AND @ENVTRA = 'N') THEN
		'S'
	ELSE	
		'N'
	END)
END)
AND CJRMVI_CODBCO = '017'
AND CJRMVI_CODEMP IS NOT NULL
group by CJRMVI_CODFOR,
CJRMVI_NROFOR, 
CJTCTA_MONEXT,
CJTCTA.CJTCTA_CLABCO,
CJRMVI.CJRMVI_MODCPT,
CJRMVI.CJRMVI_CODCPT,
CJRMVI.CJRMVI_TIPCPT,
CJRMVI.CJRMVI_CTACTE,
CJRMVI.CJRMVI_CODEMP, 
CJRMVI.CJRMVI_MODFOR,
PVMPRH.PVMPRH_TIPDOC,
PVMPRH_DIRECC,
PVMPRH_TIPDO1,
PVMPRH_TIPDO2,
PVMPRH_TIPDO3,
PVMPRH.PVMPRH_NRODOC,
PVMPRH.PVMPRH_NRODO1,
PVMPRH.PVMPRH_NRODO2,
PVMPRH.PVMPRH_NRODO3,
PVMPRH_NUMERO,
PVMPRH.PVMPRH_NOMBRE,
PVMPRH.PVMPRH_DEPTOS,
PVMPRH.PVMPRH_DPPISO,
PVMPRH.PVMPRH_CODPOS,
PVMPRH.PVMPRH_JURISD,
PVMPRH.PVMPRH_CODPAI,
PVMPRH.PVMPRH_DIREML,
PVMPRH.PVMPRH_TELEFN
ORDER BY CJRMVI_CODFOR DESC ,CJRMVI_NROFOR DESC
