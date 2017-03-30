import XMonad
import XMonad.Util.EZConfig

main = xmonad $ defaultConfig
         { modMask = mod4Mask
         , terminal = "termite"
         }
         `additionalKeysP`
         [ ("M-p", spawn "rofi -show run")
         ]
