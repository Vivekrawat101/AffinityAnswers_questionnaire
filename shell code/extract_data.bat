@echo off
setlocal enabledelayedexpansion

set "input_file=data.txt"
set "output_file=results.tsv"

if not exist "%input_file%" (
    echo Input file not found!
    exit /b 1
)

(

    for /f "usebackq tokens=1-6 delims=;" %%a in ("%input_file%") do (
        set "scheme_name=%%d"
        set "asset_value=%%e"
        if defined scheme_name (
            echo !scheme_name!	!asset_value!
        )
    )
) > "%output_file%"

echo Extraction complete. Results saved to "%output_file%"

endlocal
