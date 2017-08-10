echo on
setlocal
IF [%1] == [] (
        echo Missing destination directory argument
        goto :EOF
        )
call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" x86 || goto :EOF
echo on
set SRC=%~dp0
set DST=%1
set PATH=Q:\binary\5.6.0\msvc2015\bin;%PATH%
call configure.bat --prefix "%DST%" || goto :EOF
echo on
cd %SRC%\src
nmake install || goto :EOF
cd %SRC%\tools
nmake install || goto :EOF
