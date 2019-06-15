import XMonad 
import qualified XMonad.StackSet as W
import qualified XMonad.Util.CustomKeys as C
import qualified Data.Map as M

main :: IO ()
main = xmonad $ defaultConfig
       { borderWidth        = 0
       , terminal           = "urxvt -bg black -fg white -vb +sb"
       , workspaces         = ["shell", "web"] ++ map show [3..9]
       , normalBorderColor  = "#000000"
       , focusedBorderColor = "#000000"
       , keys = C.customKeys delkeys inskeys
       , manageHook         = manageHook defaultConfig <+> myManageHook
       }
    where
      delkeys :: XConfig l -> [(KeyMask, KeySym)]
      delkeys XConfig {modMask = modm} =
          [ (modm, xK_b) ]
      
      inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
      inskeys conf@(XConfig {modMask = modm}) =
          let font = "Monospace"
              color = "-fg white -bg black"
              urxvt = "urxvt -vb +sb" in 
          [ 
           ((modm .|. shiftMask, xK_w), spawn "firefox"),
           ((modm .|. shiftMask, xK_e), spawn 
            ("emacs --font \"" ++ font ++ "-14\" " ++ color)),
           ((modm .|. shiftMask, xK_u), spawn 
            (urxvt ++ " " ++ color ++ " -fn \"xft:" ++ font ++ 
             ":pixelsize=20\"")),
           ((modm .|. shiftMask, xK_l), spawn "xlock -mode blank")
          ]
      myManageHook :: ManageHook
      myManageHook = composeAll [
                      className   =? "Firefox-bin" --> doF(W.shift "web")
                     ]