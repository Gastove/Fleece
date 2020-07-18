Push-Location
try {
    $rootDir = [IO.Path]::Combine($PSScriptRoot, ".." , "..")
    Set-Location $rootDir
    dotnet tool restore
    if (!(Test-Path "./bin")) {
        mkdir -p ./bin
    }
    if (!(Test-Path "./packages/docs/")) {
        mkdir -p ./packages/docs/
    }
    $nuget="./bin/nuget.exe"

    if (!(Test-Path $nuget)) {
        Invoke-WebRequest -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile ./bin/nuget.exe
    }
    & $nuget install FSharp.Core "-ExcludeVersion" "-version" 4.6.2 "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install System.Runtime "-ExcludeVersion" "-version" 4.3.1  "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install MathNet.Numerics.FSharp "-ExcludeVersion" "-version" 4.8.1  -source https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install FSharp.Literate "-ExcludeVersion" "-version" 4.0.0-rc2  -source https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install FSharp.Compiler.Service "-ExcludeVersion" "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install FSharp.Formatting "-ExcludeVersion" "-version" 4.0.0-rc2 "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install TaskBuilder.fs "-ExcludeVersion" "-version" 2.1.0 "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/
    & $nuget install Suave "-ExcludeVersion" "-version" 2.5.6 "-source" https://www.nuget.org/api/v2 "-OutputDirectory" packages/docs/

}
finally {
    Pop-Location
}
