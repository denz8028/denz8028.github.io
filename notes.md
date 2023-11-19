# Заметка 1
#### Проведения termux-x11 в chroot
1. Примонтировать в linux deploy /data/data/com.termux/files/usr/tmp в /tmp в chroot.
2. в Termux открыть х11 сервер на :0
<code>termux-x11 :0 -ac<\code>
3. войти в chroot по ssh
4. выполнить <code>export DISPLAY=:0</code>
5. наслаждайтесь своим х11 в лучшем Х-сервере на андроид!
Конец заметки 1
# Заметка 2
игры для twrp можно начать делать [тут](https://www.ibiblio.org/pub/Linux/games/arcade/tetris/!INDEX.short.html)



