# Заметка 1
#### Проведения termux-x11 в chroot
1. Примонтировать в linux deploy /data/data/com.termux/files/usr/tmp в /tmp в chroot.
2. в Termux открыть х11 сервер на :0
<code>termux-x11 :0<\code>
3. установить <code>pkg in xorg-xauth</code>
4. прописать <code>export DISPLAY=:0 && xhost +</code>
5. войти в chroot по ssh
6. выполнить <code>export DISPLAY=:0</code>
7. наслаждайтесь своим х11 в лучшем Х-сервере на андроид!
Конец заметки 1



