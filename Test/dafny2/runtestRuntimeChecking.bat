@echo off
setlocal

set BOOGIEDIR=..\..\Binaries
set DAFNY_EXE=%BOOGIEDIR%\Dafny.exe
set BPLEXE=%BOOGIEDIR%\Boogie.exe

REM soon again: SnapshotableTrees.dfy

REM to implement:
REM COST-verif-comp-2011-1-MaxArray : out parameters is quantifiers

for %%f in (Classics TreeBarrier
            COST-verif-comp-2011-2-MaxTree-class
            COST-verif-comp-2011-2-MaxTree-datatype
            COST-verif-comp-2011-3-TwoDuplicates
            COST-verif-comp-2011-4-FloydCycleDetect
            Intervals StoreAndRetrieve) do (
  echo.
  echo -------------------- %%f --------------------
  %DAFNY_EXE% /nologo /errorTrace:0 /runtimeChecking:1 /compile:3 %* %%f.dfy
  if exist %%f.cs. (
    del %%f.cs
  )
  if exist %%f.exe. (
    del %%f.exe
  )
  if exist %%f.dll. (
    del %%f.dll
  )
  if exist %%f.pdb. (
    del %%f.pdb
  )
  if exist %%f.pdb.original. (
    del %%f.pdb.original
  )
)
