{-# LANGUAGE TemplateHaskell, LambdaCase #-}

import Language.Haskell.TH.Syntax (liftString, runIO)
import System.Environment (getEnv, getArgs)
import Control.Monad.IO.Class (liftIO)
import Control.Monad (join)

main :: IO ()
main = getArgs >>= \case
  [] -> putStrLn "Hello, world"
  ["--version"] -> putStrLn version
  ["-v"] -> putStrLn version
  otherwise -> error "Unknown command-line arguments!"
  where version = $(join $ liftIO $ liftString <$> getEnv "VERSION")
