with SmAda_Data;                        use SmAda_Data;
with Text_IO;

Package body UErrors is

----------------------------------------------------------------------------

FUNCTION ErrorString(Id: Integer) return String is
  BEGIN
   Case Id is
    WHEN   0  => Return  "UNDEFINED IDENTIFIER";
    WHEN   1  => Return  "MULTIPLE DEFINITION OF AN IDENTIFIER";
    WHEN   2  => Return  "MISSING AN IDENTIFIER";
    WHEN   3  => Return  "MISSING A PROCEDURE DECLARATION";
    WHEN   4  => Return  "MISSING CLOSING PARENTHESIS ``)''";
    WHEN   5  => Return  "MISSING A COLON ``:''";
    WHEN   6  => Return  "INCORRECTLY USED SYMBOL";
    WHEN   7  => Return  "MISSING IDENTIFIER";
    WHEN   8  => Return  "MISSING ``OF''";
    WHEN   9  => Return  "MISSING AN OPENING PARENTHESIS ``)''";
    WHEN  10  => Return  "MISSING IDENTIFER; ``ARRAY'' OR ``RECORD''";
    WHEN  11  => Return  "-- OPENING BRACKET ``[''";
    WHEN  12  => Return  "-- CLOSING BRACKET ``]''";
    WHEN  13  => Return  "EXPECTING ``..''";
    WHEN  14  => Return  "MISSING A SEMICOLON ``;''";
    WHEN  15  => Return  "BAD RESULT TYPE FOR A FUNCTION";
    WHEN  16  => Return  "ILLEGAL STATEMENT START SYMBOL";
    WHEN  17  => Return  "EXPECTING A BOOLEAN EXPRESSION ";
    WHEN  18  => Return  "CONTROL VARIABLE OF THE WRONG TYPE";
    WHEN  19  => Return  "FIRST/LAST MUST BE MATCHING TYPES";
    WHEN  20  => Return  "MISSING ``IS''";
    WHEN  21  => Return  "THE NUMBER IS TOO LARGE";
    WHEN  22  => Return  "INCORRECT BLOCK NAME";
    WHEN  23  => Return  "BAD TYPE FOR A CASE STATEMENT";
    WHEN  24  => Return  "ILLEGAL CHARACTER";
    WHEN  25  => Return  "ILLEGAL CONSTANT OR CONSTAT IDENTIFIER";
    WHEN  26  => Return  "ILLEGAL ARRAY SUBSCRIPT (CHECK TYPE)";
    WHEN  27  => Return  "ILLEGAL BOUNDS FOR AN ARRAY INDEX";
    WHEN  28  => Return  "INDEXED VARIABLE MUST BE AN ARRAY";
    WHEN  29  => Return  "MISSING A TYPE IDENFIFIER";
    WHEN  30  => Return  "UNDEFINED TYPE";
    WHEN  31  => Return  "VAR WITH FIELD SELECTOR MUST BE RECORD";
    WHEN  32  => Return  "RESULTING TYPE IS NOT ``BOOLEAN''";
    WHEN  33  => Return  "ILLEGAL TYPE FOR ARITHMETIC EXPRESSION";
    WHEN  34  => Return  "``MOD'' REQUIRES INTEGER ARGUMENTS";
    WHEN  35  => Return  "INCOMPATIBLE TYPES FOR COMPARISON";
    WHEN  36  => Return  "PARAMETER TYPES DO NOT MATCH";
    WHEN  37  => Return  "MISSING A VARIABLE";
    WHEN  38  => Return  "A STRING MUST HAVE ONE OR MORE CHAR";
    WHEN  39  => Return  "NUMBER OF PARAMETERS DO NOT MATCH";
    WHEN  40  => Return  "ILLEGAL PARAMETERS TO ``GET''";
    WHEN  41  => Return  "ILLEGAL PARAMETERS TO ``PUT''";
    WHEN  42  => Return  "PARAMETER MUST BE OF TYPE ``FLOAT''";
    WHEN  43  => Return  "PARAMETER MUST BE OF TYPE ``INTEGER''";
    WHEN  44  => Return  "EXPECTED A VARIABLE; FUNCTION OR CONST";
    WHEN  45  => Return  "ILLEGAL RETURN STATEMENT FROM MAIN";
    WHEN  46  => Return  "TYPES MUST MATCH IN AN ASSIGNMENT";
    WHEN  47  => Return  "CASE LABEL NOT SAME TYPE AS CASE CLAUSE";
    WHEN  48  => Return  "ARGUMENT TO STD. FUNCTION OF WRONG TYPE";
    WHEN  49  => Return  "THE PROGRAM REQUIRES TOO MUCH STORAGE";
    WHEN  50  => Return  "ILLEGAL SYMBOL FOR A CONSTANT";
    WHEN  51  => Return  "MISSING ``:=''";
    WHEN  52  => Return  "MISSING ``THEN''";
    WHEN  53  => Return  "MISSING ``IN''";
    WHEN  54  => Return  "MISSING ``LOOP''";
    WHEN  55  => Return  "MISSING RANGE ``..''";
    WHEN  56  => Return  "MISSING ``BEGIN''";
    WHEN  57  => Return  "MISSING ``END''";
    WHEN  58  => Return  "EXPECTING AN ID; CONST; ``NOT'' OR ``(''";
    WHEN  59  => Return  "MISSING ``RETURN''";
    WHEN  60  => Return  "CONTROL CHARACTER PRESENT IN SOURCE ";
    WHEN  61  => Return  "MISSING ``RECORD''";
    WHEN  62  => Return  "MISSING CLOSING ``IF''";
    WHEN  63  => Return  "MISSING ``WHEN''";
    WHEN  64  => Return  "MISSING the finger ``=''>";
    WHEN  65  => Return  "MISSING CLOSING ``CASE''";
    WHEN  66  => Return  "CHARACTER DELIMETER USED FOR STRING";
    WHEN  67  => Return  "Ada RESERVED WORD; NOT SUPPORTED";
    WHEN  68  => Return  "FUNCTIONS MUST RETURN A VALUE";
    WHEN  69  => Return  "MUST SPECIFY ``WITH SMALL_SP;''";
    WHEN  70  => Return  "MUST SPECIFY ``USE SMALL_SP;''";
    WHEN  71  => Return  "EXPECTING AN ENTRY";
    WHEN  72  => Return  "MISSING EXPRESSION FOR DELAY";
    WHEN  73  => Return  "DELAY TIME MUST BE TYPE FLOAT";
    WHEN  74  => Return  "COMMA EXPECTED";
    WHEN  75  => Return  "PARAMETER MUST BE OF TYPE ``BOOLEAN''";
    WHEN  76  => Return  "EXPECTING ``ACCEPT''; ``WHEN''; OR ENTRY ID";
    WHEN  77  => Return  "EXPECTING Task.Entry";
    WHEN  78  => Return  "EXPECTING ``OR'' OR ``ELSE'' IN SELECT";
    WHEN  79  => Return  "EXPECTING ``DELAY''";
    WHEN  80  => Return  "MISSING SELECT";
    WHEN  81  => Return  "PROGRAM INCOMPLETE";
    WHEN others => Return "Unknown error Id=" & integer'image(Id);
   end case;
  END ErrorString;

----------------------------------------------------------------------------

  PROCEDURE Error(N: Integer) is -- Write Error on current line & add To TOT ERR
  BEGIN
    cFoundError(N, LineCount, syStart, syEnd, -1);
    Errs(N) := True;
  END;

----------------------------------------------------------------------------

PROCEDURE EndSkip is -- Skip past part of input
  BEGIN
	SkipFlag := FALSE;
  END;

----------------------------------------------------------------------------

PROCEDURE Fatal(N: Integer) is			-- internal table overflow
  use Text_IO;
  BEGIN
	IF Errs /= Error_free THEN ErrorMsg; END IF;

	IF qDebug THEN
		Put("The Compiler TABLE for ");
		CASE N IS
		  WHEN  1=> Put("IDENTIFIERS");
		  WHEN 	2=> Put("PROCEDURES");
		  WHEN 	3=> Put("FLOAT Constants");
		  WHEN 	4=> Put("Arrays");
		  WHEN 	5=> Put("LEVELS");
		  WHEN 	6=> Put("OBJECT ObjCode");
		  WHEN 	7=> Put("Strings");
		  WHEN 	8=> Put("TASKS");
		  WHEN 	9=> Put("ENTRIES");
		  WHEN 	10=> Put("ObjCode PATCHING");
		  WHEN others => Put("N unknown: " & integer'image(N));
		END CASE;
		Put_Line(" is too SMALL"); New_Line;
		Put_Line(" Please take this output To the maintainer of ");
		Put_Line(" Small-Ada for your installation "); New_Line;
		Put_Line(" Fatal termination of Small-Ada");
	END IF;
	raise Failure_1_0;
END Fatal;

----------------------------------------------------------------------------

PROCEDURE ErrorMsg is
  use Text_IO;
  package IIO is new Integer_IO(integer); use IIO;
  K: Integer;
  BEGIN
	K := 0;
	IF qDebug THEN
		New_Line;
		Put_Line(" Error MESSAGE(S)");
	END IF;
	IF ListingWasRequested THEN
		New_Line(Listing);
		Put_Line(Listing, " Error MESSAGE(S)");
	END IF;
	WHILE Errs /= Error_free LOOP
		WHILE NOT Errs(K) LOOP
			K := K + 1;
		END LOOP;
		IF qDebug THEN
		  Put(K,2); Put("  "); Put_Line(ErrorString(K));
	    	END IF;
		IF ListingWasRequested THEN
		  Put(Listing,K,2); Put(Listing,"  ");
		  Put_Line(Listing,ErrorString(K));
	    END IF;
	  Errs(K):= False; -- we cancel the K-th sort of error
	END LOOP;

  END ErrorMsg;

END UErrors;
