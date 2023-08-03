import System.Environment (getArgs)
import System.Random (randomRIO)
import Data.Array ((!), listArray)

-- Lista de palabras
listaPalabras :: [String]
listaPalabras = ["arena", "arenoso", "anastasio", "aw", "alv", "ban", "biri", "boliche", "bloz", "but", "cy", "elfa", "elfo", "denle", "fake", "fantasmón", "furros", "gggg", "gfa", "guen", "grasoso", "hailgrasa", "iknorado", "imbezilo", "khe", "kyc", "kora", "la", "laura", "lince", "lincesa", "maquinola", "mamu", "momo", "momazo", "me", "naik", "niu", "nub", "nel", "nepe", "nopor", "normie", "old", "pack", "papu", "papulince", "plox", "prro", "repoio", "rikolino", "rola", "re100", "shavot", "shidori", "shitposting", "shitposter", "sergio", "sheshes", "ste", "sign", "zelda", "zopotamare", "+10", "100tífico", "<tres"]

-- Función para generar una contraseña aleatoria
generarContrasena :: Int -> Bool -> Bool -> IO String
generarContrasena longitudInPalabras incluirNumeros incluirCaracteresEspeciales = do
    indices <- generarIndicesAleatorios longitudInPalabras (length listaPalabras)
    let palabrasSeleccionadas = map (listaPalabras !!) indices
    let contrasena = unwords palabrasSeleccionadas
    numeroAleatorio <- if incluirNumeros then randomRIO (10 :: Int, 99) else pure 0
    let caracteresEspeciales = "!@#$%^&*_"
    let rangoCaracteres = listArray (0, length caracteresEspeciales - 1) caracteresEspeciales
    caracterAleatorio <- if incluirCaracteresEspeciales then randomRIO (0, length caracteresEspeciales - 1) >>= return . (rangoCaracteres !) else pure ' '
    let contrasenaFinal = contrasena ++ if incluirNumeros then show numeroAleatorio else "" ++ if incluirCaracteresEspeciales then [caracterAleatorio] else ""
    return contrasenaFinal

-- Función para generar índices aleatorios para seleccionar palabras de la lista
generarIndicesAleatorios :: Int -> Int -> IO [Int]
generarIndicesAleatorios cantidad valorMaximo = do
    indices <- mapM (\_ -> randomRIO (0, valorMaximo - 1)) [1..cantidad]
    return indices

-- Función principal
main :: IO ()
main = do
    args <- getArgs
    let longitudInPalabras = case args of
            (x:_) -> read x :: Int
            _ -> 3  -- Longitud predeterminada si no se especifica
    let incluirNumeros = "-n" `elem` args
    let incluirCaracteresEspeciales = "-s" `elem` args
    contrasena <- generarContrasena longitudInPalabras incluirNumeros incluirCaracteresEspeciales
    putStrLn contrasena
