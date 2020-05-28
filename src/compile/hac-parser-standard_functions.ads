with HAC.PCode;

private package HAC.Parser.Standard_Functions is

  --  NB: Some of the supplied subprograms may disappear when modularity,
  --  Ada.Text_IO etc. will be implemented, as well as overloading.

  procedure Standard_Function (
    CD          : in out Compiler_Data;
    Level       :        PCode.Nesting_level;
    FSys        :        Defs.Symset;
    Ident_Index :        Integer;
    Code        :        PCode.SF_Code;
    Return_Typ  :    out Exact_Typ
  );

end HAC.Parser.Standard_Functions;
