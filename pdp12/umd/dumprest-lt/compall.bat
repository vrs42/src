tcc -w -G -O -DPC -I\encom -L\encom dumprx01.c ents.lib > t
tcc -w -G -O -DPC -I\encom -L\encom restrx01.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom dumprk05.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom restrk05.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom dumptd8e.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom resttd8e.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom sendtape.c ents.lib >> t
tcc -w -G -O -DPC -I\encom -L\encom dumbterm.c ents.lib >> t
tcc -w -G -O -DPC blkdectp.c >> t
type t | more
