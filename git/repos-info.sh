MY_NAME=joequant
repos_misc="shiny-server dynamic-reverse-proxy configurable-http-proxy pyswagger"
repos_quantlib="quantlib"
repos_og="OG-PlatformNative OG-Tools OG-Platform"
repos_skip="JyNI zipline JSurface3D etherpad-lite XChange Fudge-Python ethercalc"

declare -A branch
branch[XChange]="develop"
branch[etherpad-lite]="develop"

declare -A upstream
upstream[JyNI]="https://github.com/Stewori/JyNI"
upstream[XChange]="https://github.com/timmolter/XChange"
upstream[JSurface3D]="https://github.com/OpenGamma/JSurface3D"
upstream[zipline]="https://github.com/quantopian/zipline"
upstream[trade-manager]="https://code.google.com/p/trade-manager"
upstream[etherpad-lite]="https://github.com/ether/etherpad-lite"
upstream[ethercalc]="https://github.com/audreyt/ethercalc"
upstream[shiny-server]="https://github.com/rstudio/shiny-server"
upstream[dynamic-reverse-proxy]="https://github.com/softek/dynamic-reverse-proxy"
upstream[configurable-http-proxy]="https://github.com/jupyter/configurable-http-proxy"
upstream[pyswagger]="https://github.com/mission-liao/pyswagger"

