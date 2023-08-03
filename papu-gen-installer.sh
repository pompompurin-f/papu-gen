#!/bin/sh

if ! command -v ghc >/dev/null 2>&1; then
    echo "GHC (Glasgow Haskell Compiler) no está instalado."
    echo "Por favor, instala GHC antes de ejecutar este instalador."
    exit 1
fi

ghc papu-gen.hs -o papu-gen

if [ ! -f "papu-gen" ]; then
    echo "Hubo un error durante la compilación."
    exit 1
fi

if command -v sudo >/dev/null 2>&1; then
    sudo mv papu-gen /usr/local/bin
else
    echo "Es posible que necesites permisos de administrador para mover el ejecutable a /usr/local/bin."
    echo "Por favor, ejecuta el siguiente comando con privilegios de administrador:"
    echo "mv papu-gen /usr/local/bin"
    exit 1
fi

echo "El instalador ha sido completado exitosamente."
echo "Ahora puedes ejecutar 'papu-gen' desde cualquier ubicación en la terminal."
