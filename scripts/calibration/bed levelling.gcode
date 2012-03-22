;Bed levelling code by Owen
;http://forum.ultimaker.com/viewtopic.php?f=6&t=307
;This is a Gcode file I made to more rapidly move to each corner at your set height.
;It basically raises z to 10, homes the nozzle and zeros out x, y and z.
;Then it goes to your preferred corner (the one not bracketed out) and sets z to your desired height. I set my z to 0.05mm in the code and then use a 0.05 mm feeler gauge which should squeeze between nozzle and platform with a bit of drag.
;Then make your adjustment. The initial adjustment is the end stop using this thing http://www.thingiverse.com/thing:11033 and the next 3 are the bed levelling screws.
;After you've adjusted a corner you hit the build button which makes it lower the platform by 10, home and return to that corner at z =0.05.
;Once that corner is done bracket it out in the code and unbracket the next corner.
;I set the x and y of each corner to be as close to the bed levelling screws as possible but giving room for the screw driver.
G21
G90
G1 Z10 F2000
G28
G92 X0 Y0 Z0

(RightRear)
G1 X150 Y180 Z2 F5000

(LeftRear)
(G1 X35 Y180 Z2 F5000)

(RightFront)
(G1 X145.0000 Y10 Z2 F5000)

(LeftFront)
(G1 X35 Y10 Z2 F5000)

G1 Z0.05 F200
