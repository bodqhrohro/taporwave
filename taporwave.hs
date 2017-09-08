module Main (main) where
import System.Random
import System.Posix.Unistd
import System.IO
main :: IO()

randomNumbers :: StdGen -> [Float]
randomNumbers g = (randomRs(0, 1.0) g)

multRandomNumbers :: [Float] -> Float -> [Float]
multRandomNumbers (rand:otherRands) prev = realRand : multRandomNumbers otherRands realRand
    where curRand = prev * ( 0.995 + ( rand * ( 1 /0.995 - 0.995 ) ) )
          realRand
            | curRand < 0.8 = 0.8
            | curRand > 1.2 = 1.2
            | otherwise = curRand

variatedRandomNumbers :: [Float] -> [Float]
variatedRandomNumbers rands = multRandomNumbers rands 1

currentSpeedString :: Float -> String
currentSpeedString i = "set speed " ++ ( show i )

printSpeed :: Float -> IO()
printSpeed = putStrLn . currentSpeedString

intervalPrintSpeed :: Float -> IO()
intervalPrintSpeed speed = do
    printSpeed speed
    hFlush System.IO.stdout
    usleep 10000

main = do
    g <- getStdGen
    mapM_ intervalPrintSpeed (variatedRandomNumbers $ randomNumbers g)
