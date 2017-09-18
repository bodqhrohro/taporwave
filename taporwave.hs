module Main (main) where
import System.Random
import System.Posix.Unistd
import System.IO
import Options.Applicative
import Data.Semigroup ((<>))
main :: IO()

-- arguments
minBoundParser :: Parser String
minBoundParser = strOption (
    long "minBound" <>
    metavar "MIN_BOUND" <>
    value "0.8" <>
    help "Lowest value speed can reach")

maxBoundParser :: Parser String
maxBoundParser = strOption (
    long "maxBound" <>
    metavar "MAX_BOUND" <>
    value "1.2" <>
    help "Highest value speed can reach")

data Options = Options {
    argMinBound :: String,
    argMaxBound :: String
} deriving (Show)

argsParser :: Parser Options
argsParser = Options <$> minBoundParser <*> maxBoundParser

-- functions
randomNumbers :: StdGen -> [Float]
randomNumbers g = (randomRs(0, 1.0) g)

multRandomNumbers :: [Float] -> Float -> Float -> Float -> [Float]
multRandomNumbers (rand:otherRands) prev minBound maxBound =
    realRand : multRandomNumbers otherRands realRand minBound maxBound
    where curRand = prev * ( 0.995 + ( rand * ( 1 /0.995 - 0.995 ) ) )
          realRand
            | curRand < minBound = minBound
            | curRand > maxBound = maxBound
            | otherwise = curRand

variatedRandomNumbers :: [Float] -> Float -> Float -> [Float]
variatedRandomNumbers rands minBound maxBound = multRandomNumbers rands 1 minBound maxBound

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
    opts <- (execParser (info argsParser idm))
    g <- getStdGen
    mapM_ intervalPrintSpeed (variatedRandomNumbers (randomNumbers g) (read (argMinBound opts)) (read (argMaxBound opts)))
