-------------------------------------------------------------------------------------
--
--  HAC - HAC Ada Compiler
--
--  A compiler in Ada for an Ada subset
--
--  Copyright, license, etc. : see top package.
--
-------------------------------------------------------------------------------------
--

with HAC.Co_Defs;

package HAC.Scanner is

  use Co_Defs;

  --  Source code scanning for the compiler

  procedure InSymbol (CD : in out Compiler_Data);

end HAC.Scanner;
